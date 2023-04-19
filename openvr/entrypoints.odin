package openvr

foreign import openvr_api "openvr_api.lib"
foreign openvr_api {
	@(link_name = "VR_InitInternal")
	Init :: proc "system" (peError: ^InitError, eType: ApplicationType) -> rawptr ---
	
	@(link_name = "VR_ShutdownInternal")
	Shutdown :: proc "system" () ---

	@(link_name = "VR_IsHmdPresent")
	IsHmdPresent :: proc "system" () -> bool ---

	@(link_name = "VR_GetGenericInterface")
	GetGenericInterface :: proc "system" (pchInterfaceVersion: cstring, peError: ^InitError) -> rawptr ---

	@(link_name = "VR_IsRuntimeInstalled")
	IsRuntimeInstalled :: proc "system" () -> bool ---

	@(link_name = "VR_GetVRInitErrorAsSymbol")
	GetInitErrorAsSymbol :: proc "system" (error: InitError) -> cstring ---

	@(link_name = "VR_GetVRInitErrorAsEnglishDescription")
	GetInitErrorAsDescription :: proc "system" (error: InitError) -> cstring ---
}
