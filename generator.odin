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

	for k, v in api_object {
		fmt.println(k)
	}
}

TYPEDEF_MAP := map[string]string {
	"uint32_t" = "u32",
	"uint64_t" = "u64",
	"int32_t"  = "i32",
	"int64_t"  = "i64",
	"void *"   = "rawptr",
}

generate_typedefs :: proc(defs: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n\n")


	for def in defs {
		def_obj := def.(json.Object)
		typedef := def_obj["typedef"].(json.String)
		dtype := def_obj["type"].(json.String)

		if dtype not_in TYPEDEF_MAP {
			fmt.println("Skipping", def_obj)
			continue
		}

		type_trim := strings.trim_prefix(typedef, "vr::")
		otype := TYPEDEF_MAP[dtype]
		strings.write_string(&b, fmt.aprintf("{} :: {}\n", type_trim, otype))
	}

	os.write_entire_file("openvr/defs.odin", b.buf[:])
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

generate_consts :: proc() {

}

trim_struct_name :: proc(name: string) -> string {
	struct_trim := strings.trim_prefix(name, "vr::")
	struct_trim = strings.trim_prefix(struct_trim, "VR")
	struct_trim = strings.trim_suffix(struct_trim, "_t")
	return struct_trim
}

generate_structs :: proc(structs: json.Array) {
	b := strings.builder_make()
	strings.write_string(&b, "package openvr\n\n")
	// strings.write_string(&b, "import \"core:c\"\n\n")

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

		}

		strings.write_string(&b, "}\n\n")
	}

	os.write_entire_file("openvr/structs.odin", b.buf[:])
}

generate_methods :: proc() {

}
