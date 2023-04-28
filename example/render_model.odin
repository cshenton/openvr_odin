package openvr_example

import "core:fmt"
import "core:mem"
import "core:time"

import gl "vendor:OpenGL"

import vr "../openvr"

Render_Model :: struct {
	vert_count: u32,
	idx_count:  u32,
	vao:        u32,
	vbo:        u32,
	ebo:        u32,
	tex:        u32,
}

render_model_setup :: proc(
	dev_idx: vr.TrackedDeviceIndex,
	system: ^vr.ISystem,
	render_models: ^vr.IRenderModels,
) -> (
	rm: Render_Model,
	err: AppError,
) {
	buf: [256]u8
	model_name := cstring(&buf[0])
	prop_err: vr.TrackedPropertyError
	system.GetStringTrackedDeviceProperty(dev_idx, .RenderModelName_String, model_name, 256, &prop_err)
	if prop_err != .Success {err = prop_err;return}

	render_err: vr.RenderModelError
	model: ^vr.RenderModel
	for {
		render_err = render_models.LoadRenderModel_Async(model_name, &model)
		if render_err != .Loading {break}
		time.sleep(time.Millisecond)
	}
	if render_err != .None {err = render_err;return}
	defer render_models.FreeRenderModel(model)
	model_tex: ^vr.RenderModel_TextureMap
	for {
		render_err = render_models.LoadTexture_Async(model.diffuseTextureId, &model_tex)
		if render_err != .Loading {break}
		time.sleep(time.Millisecond)
	}
	if render_err != .None {err = render_err;return}
	defer render_models.FreeTexture(model_tex)

	vert_stride := u32(size_of(vr.RenderModel_Vertex))
	rm.vert_count = model.unVertexCount
	idx_stride := u32(size_of(u16))
	rm.idx_count = model.unTriangleCount * 3

	// For simplicity, just use the old binding model, this is an OpenVR example, not an AZDO OpenGL example
	gl.GenVertexArrays(1, &rm.vao)
	gl.GenBuffers(1, &rm.vbo)
	gl.GenBuffers(1, &rm.ebo)

	gl.BindVertexArray(rm.vao)
	gl.BindBuffer(gl.ARRAY_BUFFER, rm.vbo)
	gl.BufferData(gl.ARRAY_BUFFER, int(vert_stride * rm.vert_count), model.rVertexData, gl.STATIC_DRAW)

	gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, rm.ebo)
	gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, int(idx_stride * rm.idx_count), model.rIndexData, gl.STATIC_DRAW)

	gl.EnableVertexAttribArray(0)
	gl.VertexAttribPointer(0, 3, gl.FLOAT, false, i32(vert_stride), offset_of(vr.RenderModel_Vertex, vPosition))
	gl.EnableVertexAttribArray(1)
	gl.VertexAttribPointer(1, 3, gl.FLOAT, false, i32(vert_stride), offset_of(vr.RenderModel_Vertex, vNormal))
	gl.EnableVertexAttribArray(2)
	gl.VertexAttribPointer(2, 2, gl.FLOAT, false, i32(vert_stride), offset_of(vr.RenderModel_Vertex, rfTextureCoord))

	gl.GenTextures(1, &rm.tex)
	gl.BindTexture(gl.TEXTURE_2D, rm.tex)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)
	gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR)

	image_width := i32(model_tex.unWidth)
	image_height := i32(model_tex.unHeight)
	image_data := model_tex.rubTextureMapData
	gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGBA8, image_width, image_height, 0, gl.RGBA, gl.UNSIGNED_BYTE, image_data)
	gl.GenerateMipmap(gl.TEXTURE_2D)

	return
}
