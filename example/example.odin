package openvr_example

import "core:fmt"
import vr "../openvr"

main :: proc() {
	err: vr.InitError
	vr.Init(&err, .Scene)
	if err != .None {
                err_desc := string(vr.GetInitErrorAsDescription(err))
                panic(err_desc)
        }
	defer vr.Shutdown()

	system := cast(^vr.ISystem)vr.GetGenericInterface(vr.IVRSystem_Version, &err)
	if err != .None {
                err_desc := string(vr.GetInitErrorAsDescription(err))
                panic(err_desc)
        }

	width, height: u32
	system.GetRecommendedRenderTargetSize(&width, &height)
	fmt.println("Render Target Size:", width, "x", height)
}

