package openvr_example

import "core:fmt"
import vr "../openvr"

main :: proc() {
	err: vr.InitError

	vr.Init(&err, .Scene)
	defer vr.Shutdown()
	if err != .None {
		err_desc := string(vr.GetInitErrorAsDescription(err))
		panic(err_desc)
	}

	vr_system := cast(^vr.ISystem)vr.GetGenericInterface(vr.IVRSystem_Version, &err)
	if err != .None {
		err_desc := string(vr.GetInitErrorAsDescription(err))
		panic(err_desc)
	}

	vr_compositor := cast(^vr.ICompositor)vr.GetGenericInterface(vr.IVRCompositor_Version, &err)
	if err != .None {
		err_desc := string(vr.GetInitErrorAsDescription(err))
		panic(err_desc)
	}

	vr_input := cast(^vr.IInput)vr.GetGenericInterface(vr.IVRInput_Version, &err)
	if err != .None {
		err_desc := string(vr.GetInitErrorAsDescription(err))
		panic(err_desc)
	}

	vr_rendermodels := cast(^vr.IRenderModels)vr.GetGenericInterface(vr.IVRRenderModels_Version, &err)
	if err != .None {
		err_desc := string(vr.GetInitErrorAsDescription(err))
		panic(err_desc)
	}

	// vr.TrackedDeviceIndex 
	// vr_rendermodels.LoadRenderModel_Async()

	width, height: u32
	vr_system.GetRecommendedRenderTargetSize(&width, &height)
	fmt.println("Render Target Size:", width, "x", height)

	// Startup, get all the controllers we're currently aware of explicitly
	hmd: vr.TrackedDeviceIndex
	hands: [2]vr.TrackedDeviceIndex
	trackers: [12]vr.TrackedDeviceIndex

	hmd_cnt := vr_system.GetSortedTrackedDeviceIndicesOfClass(.HMD, &hmd, 1, 0)
	hand_cnt := vr_system.GetSortedTrackedDeviceIndicesOfClass(.Controller, &hands[0], 2, 0)
	tracker_cnt := vr_system.GetSortedTrackedDeviceIndicesOfClass(.GenericTracker, &trackers[0], 12, 0)

	fmt.println("Hmd:", hmd)
	for i in 0 ..< hand_cnt {
		fmt.println("Hand:", hands[i])
		buf: [256]u8
		err: vr.TrackedPropertyError
		vr_system.GetStringTrackedDeviceProperty(hands[i], .RenderModelName_String, cstring(&buf[0]), 256, &err)
		fmt.println(cstring(&buf[0]))
	}
	for i in 0 ..< tracker_cnt {
		fmt.println("Tracker:", trackers[i])
	}

	for {
		// Pump event loop
		event: vr.Event
		for vr_system.PollNextEvent(&event, size_of(vr.Event)) {
			#partial switch (vr.EventType(event.eventType)) {
			case .TrackedDeviceActivated:
				fmt.println("Tracked Device Activated:", event.trackedDeviceIndex)
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

		// Do any per frame computation that's pose independent

		// Get the poses
		render_poses: [15]vr.TrackedDevicePose
		game_poses: [15]vr.TrackedDevicePose
		err := vr_compositor.WaitGetPoses(&render_poses[0], 15, &game_poses[0], 15)
		if err != .None {panic(fmt.aprintln(err))}

		// vr_compositor.Submit(...)
	}
}
