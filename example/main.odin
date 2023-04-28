package openvr_example

import "core:fmt"
import gl "vendor:OpenGL"
import SDL "vendor:sdl2"
import vr "../openvr"

// OpenVR stores device information using a simple index which is capped at 64
MAX_DEVICES :: vr.k_unMaxTrackedDeviceCount

Error :: enum {
	GL_Error,
	SDL_Error,
}

AppError :: union {
	Error,
	vr.InitError,
	vr.CompositorError,
	vr.RenderModelError,
	vr.TrackedPropertyError,
}

run_demo :: proc() -> (err: AppError) {
	// Init OpenVR
	init_err: vr.InitError
	vr.Init(&init_err, .Scene)
	defer vr.Shutdown()
	if init_err != .None {return init_err}

	// Get the vtables interfaces
	vr_system := cast(^vr.ISystem)vr.GetGenericInterface(vr.IVRSystem_Version, &init_err)
	if init_err != .None {return init_err}
	vr_compositor := cast(^vr.ICompositor)vr.GetGenericInterface(vr.IVRCompositor_Version, &init_err)
	if init_err != .None {return init_err}
	vr_input := cast(^vr.IInput)vr.GetGenericInterface(vr.IVRInput_Version, &init_err)
	if init_err != .None {return init_err}
	vr_rendermodels := cast(^vr.IRenderModels)vr.GetGenericInterface(vr.IVRRenderModels_Version, &init_err)
	if init_err != .None {return init_err}

	width, height: u32
	vr_system.GetRecommendedRenderTargetSize(&width, &height)
	fmt.println("Render Target Size:", width, "x", height)
	win_width := u32(width / 2)
	win_height := u32(height / 2)

	// Create Window
	window := SDL.CreateWindow("Hello OpenVR", 700, 100, i32(win_width), i32(win_height), {.SHOWN, .OPENGL})
	defer SDL.DestroyWindow(window)
	if window == nil {
		SDL.ShowSimpleMessageBox({.ERROR}, "vr.Init Failed", "failed to create window", nil)
		return
	}
	SDL.GL_SetSwapInterval(0)

	// Initialise OpenGL
	gl_context := SDL.GL_CreateContext(window)
	SDL.GL_MakeCurrent(window, gl_context)
	gl.load_up_to(3, 3, SDL.gl_set_proc_address)
	gl.Enable(gl.DEPTH_TEST)
	gl.ClearColor(0.2, 0.2, 0.3, 1.0)

	program, program_ok := gl.load_shaders_source(vertex_source, fragment_source)
	if !program_ok {return .GL_Error}
	defer gl.DeleteProgram(program)
	gl.UseProgram(program)

	uniforms := gl.get_uniforms_from_program(program)
	defer delete(uniforms)

	// Create framebuffers to render into
	left_fbuf, left_col, left_depth := framebuffer_create(i32(width), i32(height))
	right_fbuf, right_col, right_depth := framebuffer_create(i32(width), i32(height))

	// Store our device data in flat arrays
	render_poses: [MAX_DEVICES]vr.TrackedDevicePose
	game_poses: [MAX_DEVICES]vr.TrackedDevicePose
	render_models: [MAX_DEVICES]Render_Model

	// Read Headset matrices
	left_eye_transform := inverse(read_mat(vr_system.GetEyeToHeadTransform(.Left).m))
	right_eye_transform := inverse(read_mat(vr_system.GetEyeToHeadTransform(.Right).m))
	left_eye_proj := (transmute(matrix[4, 4]f32)vr_system.GetProjectionMatrix(.Left, 0.01, 100.0).m)
	right_eye_proj := (transmute(matrix[4, 4]f32)vr_system.GetProjectionMatrix(.Right, 0.01, 100.0).m)

	// Startup, get all the controllers we're currently aware of explicitly
	for i in 1 ..< MAX_DEVICES {
		if !vr_system.IsTrackedDeviceConnected(u32(i)) {continue}
		render_models[i] = render_model_setup(u32(i), vr_system, vr_rendermodels) or_return
		fmt.println(render_models[i])
	}

	for {
		// Pump event loops
		sdl_event: SDL.Event
		for SDL.PollEvent(&sdl_event) {
			if sdl_event.type == .QUIT {return}
		}

		event: vr.Event
		for vr_system.PollNextEvent(&event, size_of(vr.Event)) {
			#partial switch (vr.EventType(event.eventType)) {
			case .TrackedDeviceActivated:
				fmt.println("Tracked Device Activated:", event.trackedDeviceIndex)
				id := event.trackedDeviceIndex
				render_models[id] = render_model_setup(id, vr_system, vr_rendermodels) or_return
			case .TrackedDeviceDeactivated:
				fmt.println("Tracked Device Activated:", event.trackedDeviceIndex)
			case .TrackedDeviceUpdated:
				fmt.println("Tracked Device Activated:", event.trackedDeviceIndex)
			case .ButtonPress:
				data := event.data.controller
				fmt.println("Button Press:", vr.ButtonId(data.button))
			case .ButtonUnpress:
				data := event.data.controller
				fmt.println("Button Unpress:", vr.ButtonId(data.button))
			case .ButtonTouch:
				data := event.data.controller
				fmt.println("Button Touch:", vr.ButtonId(data.button))
			case .ButtonUntouch:
				data := event.data.controller
				fmt.println("Button Untouch:", vr.ButtonId(data.button))
			}
		}

		// Get the poses
		vr_compositor.WaitGetPoses(&render_poses[0], MAX_DEVICES, &game_poses[0], MAX_DEVICES) or_return

		// Compute our view, project, and model matrices
		head_transform := inverse(read_mat(render_poses[0].mDeviceToAbsoluteTracking.m))
		left_view_proj := (head_transform * left_eye_transform * left_eye_proj)
		right_view_proj := (head_transform * right_eye_transform * right_eye_proj)
		device_transforms: [64]matrix[4, 4]f32
		for i in 1 ..< vr.k_unMaxTrackedDeviceCount {
			device_transforms[i] = read_mat(render_poses[i].mDeviceToAbsoluteTracking.m)
		}

		// Render the Left eye
		gl.BindFramebuffer(gl.FRAMEBUFFER, left_fbuf)
		gl.Viewport(0, 0, i32(width), i32(height))
		gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
		for i in 1 ..< MAX_DEVICES {
			if !vr_system.IsTrackedDeviceConnected(u32(i)) {continue}

			rm := render_models[i]
			mvp := device_transforms[i] * left_view_proj
			gl.UniformMatrix4fv(uniforms["u_transform"].location, 1, true, &mvp[0, 0])
			gl.ActiveTexture(gl.TEXTURE0)
			gl.BindTexture(gl.TEXTURE_2D, rm.tex)
			gl.BindVertexArray(rm.vao)
			gl.DrawElements(gl.TRIANGLES, i32(rm.idx_count), gl.UNSIGNED_SHORT, nil)
		}

		// Render the right eye
		gl.BindFramebuffer(gl.FRAMEBUFFER, right_fbuf)
		gl.Viewport(0, 0, i32(width), i32(height))
		gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
		for i in 1 ..< MAX_DEVICES {
			if !vr_system.IsTrackedDeviceConnected(u32(i)) {continue}

			rm := render_models[i]
			mvp := device_transforms[i] * right_view_proj
			gl.UniformMatrix4fv(uniforms["u_transform"].location, 1, true, &mvp[0, 0])
			gl.ActiveTexture(gl.TEXTURE0)
			gl.BindTexture(gl.TEXTURE_2D, rm.tex)
			gl.BindVertexArray(rm.vao)
			gl.DrawElements(gl.TRIANGLES, i32(rm.idx_count), gl.UNSIGNED_SHORT, nil)
		}

		// Present the frames to the OpenVR compositor
		vr_left_tex := vr.Texture {
			handle      = transmute(rawptr)i64(left_col),
			eType       = .OpenGL,
			eColorSpace = .Auto,
		}
		vr_right_tex := vr.Texture {
			handle      = transmute(rawptr)i64(right_col),
			eType       = .OpenGL,
			eColorSpace = .Auto,
		}
		bounds := vr.TextureBounds{0, 0, 1, 1}
		vr_compositor.Submit(.Left, &vr_left_tex, &bounds, {})
		vr_compositor.Submit(.Right, &vr_right_tex, &bounds, {})

		// Copy the right eye to the window
		gl.BindFramebuffer(gl.READ_FRAMEBUFFER, right_fbuf)
		gl.BindFramebuffer(gl.DRAW_FRAMEBUFFER, 0) // window
		gl.BlitFramebuffer(
			0,
			0,
			i32(width),
			i32(height),
			0,
			0,
			i32(win_width),
			i32(win_height),
			gl.COLOR_BUFFER_BIT,
			gl.LINEAR,
		)
		SDL.GL_SwapWindow(window)
	}
}

framebuffer_create :: proc(width, height: i32) -> (fbuf, col, depth: u32) {
	gl.GenFramebuffers(1, &fbuf)
	gl.BindFramebuffer(gl.FRAMEBUFFER, fbuf)

	gl.GenTextures(1, &col)
	gl.BindTexture(gl.TEXTURE_2D, col)
	gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGBA8, width, height, 0, gl.RGB, gl.UNSIGNED_BYTE, nil)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST)

	gl.GenRenderbuffers(1, &depth)
	gl.BindRenderbuffer(gl.RENDERBUFFER, depth)
	gl.RenderbufferStorage(gl.RENDERBUFFER, gl.DEPTH_COMPONENT, width, height)
	gl.FramebufferRenderbuffer(gl.FRAMEBUFFER, gl.DEPTH_ATTACHMENT, gl.RENDERBUFFER, depth)

	gl.FramebufferTexture(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, col, 0)
	draw_bufs := [1]u32{gl.COLOR_ATTACHMENT0}
	gl.DrawBuffers(1, &draw_bufs[0])

	if gl.CheckFramebufferStatus(gl.FRAMEBUFFER) != gl.FRAMEBUFFER_COMPLETE {
		panic("shite")
	}

	return
}

read_mat :: proc(m: [3][4]f32) -> (r: matrix[4, 4]f32) {
	r[0, 0], r[1, 0], r[2, 0], r[3, 0] = m[0][0], m[1][0], m[2][0], 0
	r[0, 1], r[1, 1], r[2, 1], r[3, 1] = m[0][1], m[1][1], m[2][1], 0
	r[0, 2], r[1, 2], r[2, 2], r[3, 2] = m[0][2], m[1][2], m[2][2], 0
	r[0, 3], r[1, 3], r[2, 3], r[3, 3] = m[0][3], m[1][3], m[2][3], 1

	r = transpose(r)
	return
}

main :: proc() {
	err := run_demo()
	if err == nil {return}
	fmt.println(err)
}

vertex_source := `#version 330 core
layout(location=0) in vec3 a_position;
layout(location=1) in vec3 a_normal;
layout(location=2) in vec2 a_uv;
out vec3 v_normal;
out vec2 v_uv;
uniform mat4 u_transform;
void main() {	
	gl_Position = u_transform * vec4(a_position, 1.0);
	v_normal = a_normal;
	v_uv = a_uv;
}
`

fragment_source := `#version 330 core
in vec3 v_normal;
in vec2 v_uv;
out vec4 o_color;
uniform sampler2D u_albedo;
void main() {
	o_color = texture(u_albedo, v_uv);
}
`
