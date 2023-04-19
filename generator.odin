package openvr_odin

import "core:encoding/json"
import "core:fmt"
import "core:os"
import "core:strings"

openvr_api_json := #load("openvr_api.json")

main :: proc() {
	api, err := json.parse(openvr_api_json)
	if err != .None {panic("Failed to parse openvr_api.json")}
	api_object, ok := api.(json.Object)
	if !ok {panic("API was not object")}

	generate_typedefs(api_object["typedefs"].(json.Array))
	generate_enums(api_object["enums"].(json.Array))
	generate_structs(api_object["structs"].(json.Array))
	generate_methods(api_object["methods"].(json.Array))
	generate_consts(api_object["consts"].(json.Array))

	for k, v in api_object {
		fmt.println(k)
	}
}

TYPEDEF_MAP := map[string]string {
	"uint8_t"                     = "u8",
	"uint16_t"                    = "u16",
	"uint32_t"                    = "u32",
	"uint64_t"                    = "u64",
	"int8_t"                      = "i8",
	"int16_t"                     = "i16",
	"int32_t"                     = "i32",
	"int64_t"                     = "i64",
	"void *"                      = "rawptr",
	"_Bool"                       = "bool",
	"char"                        = "u8",
	"float"                       = "f32",
	"double"                      = "f64",
	"const uint8_t *"             = "[^]u8",
	"const char *"                = "cstring",
	"char *"                      = "cstring",
	"struct VkInstance_T *"       = "vk.Instance",
	"struct VkDevice_T *"         = "vk.Device",
	"struct VkPhysicalDevice_T *" = "vk.PhysicalDevice",
	"struct VkQueue_T *"          = "vk.Queue",
	"struct ID3D12Resource *"     = "^D3D12.IResource",
	"struct ID3D12CommandQueue *" = "^D3D12.ICommandQueue",
	"vr::IVRSystem"               = "ISystem",
	"vr::IVRChaperone"            = "IChaperone",
	"vr::IVRChaperoneSetup"       = "IChaperoneSetup",
	"vr::IVRCompositor"           = "ICompositor",
	"vr::IVRHeadsetView"          = "IHeadsetView",
	"vr::IVROverlay"              = "IOverlay",
	"vr::IVROverlayView"          = "IOverlayView",
	"vr::IVRResources"            = "IResources",
	"vr::IVRRenderModels"         = "IRenderModels",
	"vr::IVRExtendedDisplay"      = "IExtendedDisplay",
	"vr::IVRSettings"             = "ISettings",
	"vr::IVRApplications"         = "IApplications",
	"vr::IVRTrackedCamera"        = "ITrackedCamera",
	"vr::IVRScreenshots"          = "IScreenshots",
	"vr::IVRDriverManager"        = "IDriverManager",
	"vr::IVRInput"                = "IInput",
	"vr::IVRIOBuffer"             = "IIOBuffer",
	"vr::IVRSpatialAnchors"       = "ISpatialAnchors",
	"vr::IVRDebug"                = "IDebug",
	"vr::IVRNotifications"        = "INotifications",
	"vr::IVRProperties"           = "IProperties",
}

REDUNDANT_TYPEDEFS := map[string]bool {
	"TrackedDeviceClass"                    = true,
	"ColorSpace"                            = true,
	"TrackingUniverseOrigin"                = true,
	"TrackedDeviceProperty"                 = true,
	"TrackedPropertyError"                  = true,
	"SubmitFlags"                           = true,
	"State"                                 = true,
	"CollisionBoundsStyle"                  = true,
	"OverlayError"                          = true,
	"FirmwareError"                         = true,
	"CompositorError"                       = true,
	"Event_Data"                            = true,
	"OverlayIntersectionMaskPrimitive_Data" = true,
}

generate_typedefs :: proc(defs: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n\n")


	for def in defs {
		def_obj := def.(json.Object)
		typedef := def_obj["typedef"].(json.String)
		dtype := def_obj["type"].(json.String)

		type_trim := trim_struct_name(typedef)
		otype, ok := TYPEDEF_MAP[dtype]
		if !ok {otype = field_type_convert(dtype)}
		if otype in REDUNDANT_TYPEDEFS {continue}
		strings.write_string(&b, fmt.aprintf("{} :: {}\n", type_trim, otype))
	}

	os.write_entire_file("openvr/defs.odin", b.buf[:])
}


generate_consts :: proc(consts: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n\n")

	for con in consts {
		con_obj := con.(json.Object)
		constname := con_obj["constname"].(json.String)
		consttype := con_obj["consttype"].(json.String)
		constval := con_obj["constval"].(json.String)

		if consttype == "const char *const" || consttype == "const char *" {
			strings.write_string(&b, fmt.aprintf("{} :: \"{}\"\n", constname, constval))
		} else {
			strings.write_string(&b, fmt.aprintf("{} :: {}\n", constname, constval))
		}
	}

	os.write_entire_file("openvr/consts.odin", b.buf[:])
}

ENUM_NONSTANDARD_PREFIXES := [?]string{
	"k_",
	"Prop_",
	"TrackedProp_",
	"Submit_",
	"VREvent_",
	"EDeviceActivityLevel_",
	"EButton_",
	"ShowUI_",
	"eHiddenAreaMesh_",
	"eControllerAxis_",
	"ControllerEventOutput_",
	"VRApplication_",
	"VRSkeletalTracking_",
	"EVRTrackedCameraFrameLayout_",
	"OffScale_",
	"Error_",
	"Property_",
	"EVRSceneApplicationState_",
	"VROverlayTransform_",
	"EGamepadTextInputMode",
	"EGamepadTextInputLineMode",
	"OverlayIntersectionPrimitiveType_",
	"KeyboardFlag_",
	"HeadsetViewMode_",
	"EVRNotificationType_",
	"EVRNotificationStyle_",
	"VRInputFilterCancel_",
	"VRInputString_",
	"IOBuffer_",
	"BlockQueueRead_",
}

trim_enum_name :: proc(name: string) -> string {
	enum_trim := strings.trim_prefix(name, "vr::")
	enum_trim = strings.trim_prefix(enum_trim, "E")
	enum_trim = strings.trim_prefix(enum_trim, "VR")
	return enum_trim
}

generate_enums :: proc(enums: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n\n")
	strings.write_string(&b, "import \"core:c\"\n\n")

	for e in enums {
		enum_obj := e.(json.Object)
		enum_name := enum_obj["enumname"].(json.String)

		enum_trim := trim_enum_name(enum_name)
		strings.write_string(&b, fmt.aprintf("{} :: enum c.int {{\n", enum_trim))
		for val in enum_obj["values"].(json.Array) {
			val_obj := val.(json.Object)
			mem_name := val_obj["name"].(json.String)
			mem_val := val_obj["value"].(json.String)

			name_trim := mem_name
			for pref in ENUM_NONSTANDARD_PREFIXES {
				name_trim = strings.trim_prefix(name_trim, pref)
			}

			name_trim = strings.trim_prefix(name_trim, "VR")
			name_trim = strings.trim_prefix(name_trim, enum_trim)
			name_trim = strings.trim_prefix(name_trim, "_")

			if strings.has_prefix(name_trim, "COLLISION_BOUNDS_STYLE_") {
				name_trim = strings.trim_prefix(name_trim, "COLLISION_BOUNDS_STYLE_")
				name_trim = strings.to_upper_camel_case(name_trim)
			}

			// TODO: trim member names
			strings.write_string(&b, fmt.aprintf("\t{} = {},\n", name_trim, mem_val))
		}
		strings.write_string(&b, "}\n\n")
	}

	os.write_entire_file("openvr/enums.odin", b.buf[:])
}


trim_struct_name :: proc(name: string) -> string {
	struct_trim := strings.trim_prefix(name, "vr::")
	struct_trim = strings.trim_prefix(struct_trim, "VR")
	struct_trim = strings.trim_suffix(struct_trim, "_t")
	return struct_trim
}

trim_handle_name :: proc(name: string) -> string {
	handle_trim := strings.trim_prefix(name, "vr::")
	handle_trim = strings.trim_prefix(handle_trim, "VR")
	handle_trim = strings.trim_suffix(handle_trim, "_t")
	return handle_trim
}

trim_field_name :: proc(name: string) -> string {
	field_trim := strings.trim_prefix(name, "m_")
	// field_trim = strings.trim_prefix(field_trim, "fl")
	// field_trim = strings.trim_prefix(field_trim, "n")
	// field_trim = strings.trim_prefix(field_trim, "un")
	return field_trim
}

field_type_convert :: proc(name: string) -> string {
	// Check for simple match
	typename, ok := TYPEDEF_MAP[name]
	if ok {return typename}
	tokens := strings.split(name, " ")
	st := 0
	en := len(tokens) - 1
	is_const := false
	is_union := false
	is_enum := false
	is_class := false
	is_struct := false
	is_ptr := false
	is_array := false
	vr_name := ""
	array_string := ""

	if tokens[st] == "const" {
		is_const = true
		st += 1
	}

	if tokens[st] == "union" {
		is_union = true
		st += 1
	}


	if tokens[st] == "enum" {
		is_enum = true
		st += 1
	}


	if tokens[st] == "struct" {
		is_struct = true
		st += 1
	}

	if tokens[st] == "class" {
		is_class = true
		st += 1
	}

	if tokens[en] == "*" {
		is_ptr = true
		en -= 1
	}

	if strings.has_suffix(tokens[en], "]") {
		is_array = true
		array_string = tokens[en]
		en -= 1
	}

	if st != en {fmt.println(name)}

	corename := tokens[st]
	coretype, type_ok := TYPEDEF_MAP[corename]
	if !type_ok {
		coretype = trim_enum_name(corename)
		coretype = trim_struct_name(coretype)
	}
	result := fmt.aprintf("{}{}{}", is_ptr ? "^" : "", array_string, coretype)
	return result
}

STRUCT_PRELUDE :: `
import vk "vendor:vulkan"
import D3D11 "vendor:directx/d3d11"
import D3D12 "vendor:directx/d3d12"

`

generate_structs :: proc(structs: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n")
	strings.write_string(&b, STRUCT_PRELUDE)

	for str in structs {
		struct_obj := str.(json.Object)
		struct_name := struct_obj["struct"].(json.String)
		struct_fields := struct_obj["fields"].(json.Array)

		struct_trim := trim_struct_name(struct_name)
		if struct_trim == "(anonymous)" && len(struct_fields) == 2 {
			struct_trim = "OverlayIntersectionMaskPrimitive_Data"
		} else if struct_trim == "(anonymous)" {
			struct_trim = "Event_Data"
		}

		if struct_name == "vr::(anonymous)" {
			strings.write_string(&b, fmt.aprintf("{} :: struct #raw_union {{\n", struct_trim))
		} else {
			strings.write_string(&b, fmt.aprintf("{} :: struct {{\n", struct_trim))
		}

		for field in struct_fields {
			field_obj := field.(json.Object)
			fieldname := field_obj["fieldname"].(json.String)
			fieldtype := field_obj["fieldtype"].(json.String)
			odin_type := field_type_convert(fieldtype)

			fieldname_trim := trim_field_name(fieldname)
			strings.write_string(&b, fmt.aprintf("\t{}: {},\n", fieldname_trim, odin_type))
		}

		strings.write_string(&b, "}\n\n")
	}

	os.write_entire_file("openvr/structs.odin", b.buf[:])
}

INTERFACE_NAMES := [?]string{
	"IVRSystem",
	"IVRChaperone",
	"IVRChaperoneSetup",
	"IVRCompositor",
	"IVRHeadsetView",
	"IVROverlay",
	"IVROverlayView",
	"IVRResources",
	"IVRRenderModels",
	"IVRExtendedDisplay",
	"IVRSettings",
	"IVRApplications",
	"IVRTrackedCamera",
	"IVRScreenshots",
	"IVRDriverManager",
	"IVRInput",
	"IVRIOBuffer",
	"IVRSpatialAnchors",
	"IVRDebug",
	"IVRNotifications",
	"IVRProperties",
}

generate_methods :: proc(methods: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n\n")

	for iface in INTERFACE_NAMES {
		iface_trim := strings.trim_prefix(iface, "IVR")
		strings.write_string(&b, fmt.aprintf("I{} :: struct {{\n", iface_trim))
		strings.write_string(&b, "}\n\n")
	}

	os.write_entire_file("openvr/procedures.odin", b.buf[:])

}
