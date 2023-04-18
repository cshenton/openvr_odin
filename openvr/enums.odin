package openvr

import "core:c"

VREye :: enum c.int {
	Eye_Left = 0,
	Eye_Right = 1,
}

TextureType :: enum c.int {
	Invalid = -1,
	DirectX = 0,
	OpenGL = 1,
	Vulkan = 2,
	IOSurface = 3,
	DirectX12 = 4,
	DXGISharedHandle = 5,
	Metal = 6,
}

ColorSpace :: enum c.int {
	Auto = 0,
	Gamma = 1,
	Linear = 2,
}

TrackingResult :: enum c.int {
	Uninitialized = 1,
	Calibrating_InProgress = 100,
	Calibrating_OutOfRange = 101,
	Running_OK = 200,
	Running_OutOfRange = 201,
	Fallback_RotationOnly = 300,
}

TrackedDeviceClass :: enum c.int {
	Invalid = 0,
	HMD = 1,
	Controller = 2,
	GenericTracker = 3,
	TrackingReference = 4,
	DisplayRedirect = 5,
	Max = 6,
}

TrackedControllerRole :: enum c.int {
	Invalid = 0,
	LeftHand = 1,
	RightHand = 2,
	OptOut = 3,
	Treadmill = 4,
	Stylus = 5,
	Max = 5,
}

TrackingUniverseOrigin :: enum c.int {
	TrackingUniverseSeated = 0,
	TrackingUniverseStanding = 1,
	TrackingUniverseRawAndUncalibrated = 2,
}

AdditionalRadioFeatures :: enum c.int {
	None = 0,
	HTCLinkBox = 1,
	InternalDongle = 2,
	ExternalDongle = 4,
}

TrackedDeviceProperty :: enum c.int {
	Invalid = 0,
	TrackingSystemName_String = 1000,
	ModelNumber_String = 1001,
	SerialNumber_String = 1002,
	RenderModelName_String = 1003,
	WillDriftInYaw_Bool = 1004,
	ManufacturerName_String = 1005,
	TrackingFirmwareVersion_String = 1006,
	HardwareRevision_String = 1007,
	AllWirelessDongleDescriptions_String = 1008,
	ConnectedWirelessDongle_String = 1009,
	DeviceIsWireless_Bool = 1010,
	DeviceIsCharging_Bool = 1011,
	DeviceBatteryPercentage_Float = 1012,
	StatusDisplayTransform_Matrix34 = 1013,
	Firmware_UpdateAvailable_Bool = 1014,
	Firmware_ManualUpdate_Bool = 1015,
	Firmware_ManualUpdateURL_String = 1016,
	HardwareRevision_Uint64 = 1017,
	FirmwareVersion_Uint64 = 1018,
	FPGAVersion_Uint64 = 1019,
	VRCVersion_Uint64 = 1020,
	RadioVersion_Uint64 = 1021,
	DongleVersion_Uint64 = 1022,
	BlockServerShutdown_Bool = 1023,
	CanUnifyCoordinateSystemWithHmd_Bool = 1024,
	ContainsProximitySensor_Bool = 1025,
	DeviceProvidesBatteryStatus_Bool = 1026,
	DeviceCanPowerOff_Bool = 1027,
	Firmware_ProgrammingTarget_String = 1028,
	DeviceClass_Int32 = 1029,
	HasCamera_Bool = 1030,
	DriverVersion_String = 1031,
	Firmware_ForceUpdateRequired_Bool = 1032,
	ViveSystemButtonFixRequired_Bool = 1033,
	ParentDriver_Uint64 = 1034,
	ResourceRoot_String = 1035,
	RegisteredDeviceType_String = 1036,
	InputProfilePath_String = 1037,
	NeverTracked_Bool = 1038,
	NumCameras_Int32 = 1039,
	CameraFrameLayout_Int32 = 1040,
	CameraStreamFormat_Int32 = 1041,
	AdditionalDeviceSettingsPath_String = 1042,
	Identifiable_Bool = 1043,
	BootloaderVersion_Uint64 = 1044,
	AdditionalSystemReportData_String = 1045,
	CompositeFirmwareVersion_String = 1046,
	Firmware_RemindUpdate_Bool = 1047,
	PeripheralApplicationVersion_Uint64 = 1048,
	ManufacturerSerialNumber_String = 1049,
	ComputedSerialNumber_String = 1050,
	EstimatedDeviceFirstUseTime_Int32 = 1051,
	DevicePowerUsage_Float = 1052,
	IgnoreMotionForStandby_Bool = 1053,
	ReportsTimeSinceVSync_Bool = 2000,
	SecondsFromVsyncToPhotons_Float = 2001,
	DisplayFrequency_Float = 2002,
	UserIpdMeters_Float = 2003,
	CurrentUniverseId_Uint64 = 2004,
	PreviousUniverseId_Uint64 = 2005,
	DisplayFirmwareVersion_Uint64 = 2006,
	IsOnDesktop_Bool = 2007,
	DisplayMCType_Int32 = 2008,
	DisplayMCOffset_Float = 2009,
	DisplayMCScale_Float = 2010,
	EdidVendorID_Int32 = 2011,
	DisplayMCImageLeft_String = 2012,
	DisplayMCImageRight_String = 2013,
	DisplayGCBlackClamp_Float = 2014,
	EdidProductID_Int32 = 2015,
	CameraToHeadTransform_Matrix34 = 2016,
	DisplayGCType_Int32 = 2017,
	DisplayGCOffset_Float = 2018,
	DisplayGCScale_Float = 2019,
	DisplayGCPrescale_Float = 2020,
	DisplayGCImage_String = 2021,
	LensCenterLeftU_Float = 2022,
	LensCenterLeftV_Float = 2023,
	LensCenterRightU_Float = 2024,
	LensCenterRightV_Float = 2025,
	UserHeadToEyeDepthMeters_Float = 2026,
	CameraFirmwareVersion_Uint64 = 2027,
	CameraFirmwareDescription_String = 2028,
	DisplayFPGAVersion_Uint64 = 2029,
	DisplayBootloaderVersion_Uint64 = 2030,
	DisplayHardwareVersion_Uint64 = 2031,
	AudioFirmwareVersion_Uint64 = 2032,
	CameraCompatibilityMode_Int32 = 2033,
	ScreenshotHorizontalFieldOfViewDegrees_Float = 2034,
	ScreenshotVerticalFieldOfViewDegrees_Float = 2035,
	DisplaySuppressed_Bool = 2036,
	DisplayAllowNightMode_Bool = 2037,
	DisplayMCImageWidth_Int32 = 2038,
	DisplayMCImageHeight_Int32 = 2039,
	DisplayMCImageNumChannels_Int32 = 2040,
	DisplayMCImageData_Binary = 2041,
	SecondsFromPhotonsToVblank_Float = 2042,
	DriverDirectModeSendsVsyncEvents_Bool = 2043,
	DisplayDebugMode_Bool = 2044,
	GraphicsAdapterLuid_Uint64 = 2045,
	DriverProvidedChaperonePath_String = 2048,
	ExpectedTrackingReferenceCount_Int32 = 2049,
	ExpectedControllerCount_Int32 = 2050,
	NamedIconPathControllerLeftDeviceOff_String = 2051,
	NamedIconPathControllerRightDeviceOff_String = 2052,
	NamedIconPathTrackingReferenceDeviceOff_String = 2053,
	DoNotApplyPrediction_Bool = 2054,
	CameraToHeadTransforms_Matrix34_Array = 2055,
	DistortionMeshResolution_Int32 = 2056,
	DriverIsDrawingControllers_Bool = 2057,
	DriverRequestsApplicationPause_Bool = 2058,
	DriverRequestsReducedRendering_Bool = 2059,
	MinimumIpdStepMeters_Float = 2060,
	AudioBridgeFirmwareVersion_Uint64 = 2061,
	ImageBridgeFirmwareVersion_Uint64 = 2062,
	ImuToHeadTransform_Matrix34 = 2063,
	ImuFactoryGyroBias_Vector3 = 2064,
	ImuFactoryGyroScale_Vector3 = 2065,
	ImuFactoryAccelerometerBias_Vector3 = 2066,
	ImuFactoryAccelerometerScale_Vector3 = 2067,
	ConfigurationIncludesLighthouse20Features_Bool = 2069,
	AdditionalRadioFeatures_Uint64 = 2070,
	CameraWhiteBalance_Vector4_Array = 2071,
	CameraDistortionFunction_Int32_Array = 2072,
	CameraDistortionCoefficients_Float_Array = 2073,
	ExpectedControllerType_String = 2074,
	HmdTrackingStyle_Int32 = 2075,
	DriverProvidedChaperoneVisibility_Bool = 2076,
	HmdColumnCorrectionSettingPrefix_String = 2077,
	CameraSupportsCompatibilityModes_Bool = 2078,
	SupportsRoomViewDepthProjection_Bool = 2079,
	DisplayAvailableFrameRates_Float_Array = 2080,
	DisplaySupportsMultipleFramerates_Bool = 2081,
	DisplayColorMultLeft_Vector3 = 2082,
	DisplayColorMultRight_Vector3 = 2083,
	DisplaySupportsRuntimeFramerateChange_Bool = 2084,
	DisplaySupportsAnalogGain_Bool = 2085,
	DisplayMinAnalogGain_Float = 2086,
	DisplayMaxAnalogGain_Float = 2087,
	CameraExposureTime_Float = 2088,
	CameraGlobalGain_Float = 2089,
	DashboardScale_Float = 2091,
	PeerButtonInfo_String = 2092,
	IpdUIRangeMinMeters_Float = 2100,
	IpdUIRangeMaxMeters_Float = 2101,
	Hmd_SupportsHDCP14LegacyCompat_Bool = 2102,
	Hmd_SupportsMicMonitoring_Bool = 2103,
	Hmd_SupportsDisplayPortTrainingMode_Bool = 2104,
	SupportsRoomViewDirect_Bool = 2105,
	SupportsAppThrottling_Bool = 2106,
	DriverRequestedMuraCorrectionMode_Int32 = 2200,
	DriverRequestedMuraFeather_InnerLeft_Int32 = 2201,
	DriverRequestedMuraFeather_InnerRight_Int32 = 2202,
	DriverRequestedMuraFeather_InnerTop_Int32 = 2203,
	DriverRequestedMuraFeather_InnerBottom_Int32 = 2204,
	DriverRequestedMuraFeather_OuterLeft_Int32 = 2205,
	DriverRequestedMuraFeather_OuterRight_Int32 = 2206,
	DriverRequestedMuraFeather_OuterTop_Int32 = 2207,
	DriverRequestedMuraFeather_OuterBottom_Int32 = 2208,
	Audio_DefaultPlaybackDeviceId_String = 2300,
	Audio_DefaultRecordingDeviceId_String = 2301,
	Audio_DefaultPlaybackDeviceVolume_Float = 2302,
	Audio_SupportsDualSpeakerAndJackOutput_Bool = 2303,
	AttachedDeviceId_String = 3000,
	SupportedButtons_Uint64 = 3001,
	Axis0Type_Int32 = 3002,
	Axis1Type_Int32 = 3003,
	Axis2Type_Int32 = 3004,
	Axis3Type_Int32 = 3005,
	Axis4Type_Int32 = 3006,
	ControllerRoleHint_Int32 = 3007,
	FieldOfViewLeftDegrees_Float = 4000,
	FieldOfViewRightDegrees_Float = 4001,
	FieldOfViewTopDegrees_Float = 4002,
	FieldOfViewBottomDegrees_Float = 4003,
	TrackingRangeMinimumMeters_Float = 4004,
	TrackingRangeMaximumMeters_Float = 4005,
	ModeLabel_String = 4006,
	CanWirelessIdentify_Bool = 4007,
	Nonce_Int32 = 4008,
	IconPathName_String = 5000,
	NamedIconPathDeviceOff_String = 5001,
	NamedIconPathDeviceSearching_String = 5002,
	NamedIconPathDeviceSearchingAlert_String = 5003,
	NamedIconPathDeviceReady_String = 5004,
	NamedIconPathDeviceReadyAlert_String = 5005,
	NamedIconPathDeviceNotReady_String = 5006,
	NamedIconPathDeviceStandby_String = 5007,
	NamedIconPathDeviceAlertLow_String = 5008,
	NamedIconPathDeviceStandbyAlert_String = 5009,
	DisplayHiddenArea_Binary_Start = 5100,
	DisplayHiddenArea_Binary_End = 5150,
	ParentContainer = 5151,
	OverrideContainer_Uint64 = 5152,
	UserConfigPath_String = 6000,
	InstallPath_String = 6001,
	HasDisplayComponent_Bool = 6002,
	HasControllerComponent_Bool = 6003,
	HasCameraComponent_Bool = 6004,
	HasDriverDirectModeComponent_Bool = 6005,
	HasVirtualDisplayComponent_Bool = 6006,
	HasSpatialAnchorsSupport_Bool = 6007,
	ControllerType_String = 7000,
	ControllerHandSelectionPriority_Int32 = 7002,
	VendorSpecific_Reserved_Start = 10000,
	VendorSpecific_Reserved_End = 10999,
	Max = 1000000,
}

TrackedPropertyError :: enum c.int {
	Success = 0,
	WrongDataType = 1,
	WrongDeviceClass = 2,
	BufferTooSmall = 3,
	UnknownProperty = 4,
	InvalidDevice = 5,
	CouldNotContactServer = 6,
	ValueNotProvidedByDevice = 7,
	StringExceedsMaximumLength = 8,
	NotYetAvailable = 9,
	PermissionDenied = 10,
	InvalidOperation = 11,
	CannotWriteToWildcards = 12,
	IPCReadFailure = 13,
	OutOfMemory = 14,
	InvalidContainer = 15,
}

HmdTrackingStyle :: enum c.int {
	Unknown = 0,
	Lighthouse = 1,
	OutsideInCameras = 2,
	InsideOutCameras = 3,
}

VRSubmitFlags :: enum c.int {
	Default = 0,
	LensDistortionAlreadyApplied = 1,
	GlRenderBuffer = 2,
	Reserved = 4,
	TextureWithPose = 8,
	TextureWithDepth = 16,
	FrameDiscontinuty = 32,
	VulkanTextureWithArrayData = 64,
	GlArrayTexture = 128,
	Reserved2 = 32768,
	Reserved3 = 65536,
}

VRState :: enum c.int {
	Undefined = -1,
	Off = 0,
	Searching = 1,
	Searching_Alert = 2,
	Ready = 3,
	Ready_Alert = 4,
	NotReady = 5,
	Standby = 6,
	Ready_Alert_Low = 7,
}

VREventType :: enum c.int {
	None = 0,
	TrackedDeviceActivated = 100,
	TrackedDeviceDeactivated = 101,
	TrackedDeviceUpdated = 102,
	TrackedDeviceUserInteractionStarted = 103,
	TrackedDeviceUserInteractionEnded = 104,
	IpdChanged = 105,
	EnterStandbyMode = 106,
	LeaveStandbyMode = 107,
	TrackedDeviceRoleChanged = 108,
	WatchdogWakeUpRequested = 109,
	LensDistortionChanged = 110,
	PropertyChanged = 111,
	WirelessDisconnect = 112,
	WirelessReconnect = 113,
	ButtonPress = 200,
	ButtonUnpress = 201,
	ButtonTouch = 202,
	ButtonUntouch = 203,
	Modal_Cancel = 257,
	MouseMove = 300,
	MouseButtonDown = 301,
	MouseButtonUp = 302,
	FocusEnter = 303,
	FocusLeave = 304,
	ScrollDiscrete = 305,
	TouchPadMove = 306,
	OverlayFocusChanged = 307,
	ReloadOverlays = 308,
	ScrollSmooth = 309,
	LockMousePosition = 310,
	UnlockMousePosition = 311,
	InputFocusCaptured = 400,
	InputFocusReleased = 401,
	SceneApplicationChanged = 404,
	SceneFocusChanged = 405,
	InputFocusChanged = 406,
	SceneApplicationUsingWrongGraphicsAdapter = 408,
	ActionBindingReloaded = 409,
	HideRenderModels = 410,
	ShowRenderModels = 411,
	SceneApplicationStateChanged = 412,
	ConsoleOpened = 420,
	ConsoleClosed = 421,
	OverlayShown = 500,
	OverlayHidden = 501,
	DashboardActivated = 502,
	DashboardDeactivated = 503,
	DashboardRequested = 505,
	ResetDashboard = 506,
	ImageLoaded = 508,
	ShowKeyboard = 509,
	HideKeyboard = 510,
	OverlayGamepadFocusGained = 511,
	OverlayGamepadFocusLost = 512,
	OverlaySharedTextureChanged = 513,
	ScreenshotTriggered = 516,
	ImageFailed = 517,
	DashboardOverlayCreated = 518,
	SwitchGamepadFocus = 519,
	RequestScreenshot = 520,
	ScreenshotTaken = 521,
	ScreenshotFailed = 522,
	SubmitScreenshotToDashboard = 523,
	ScreenshotProgressToDashboard = 524,
	PrimaryDashboardDeviceChanged = 525,
	RoomViewShown = 526,
	RoomViewHidden = 527,
	ShowUI = 528,
	ShowDevTools = 529,
	DesktopViewUpdating = 530,
	DesktopViewReady = 531,
	StartDashboard = 532,
	ElevatePrism = 533,
	OverlayClosed = 534,
	Notification_Shown = 600,
	Notification_Hidden = 601,
	Notification_BeginInteraction = 602,
	Notification_Destroyed = 603,
	Quit = 700,
	ProcessQuit = 701,
	QuitAcknowledged = 703,
	DriverRequestedQuit = 704,
	RestartRequested = 705,
	InvalidateSwapTextureSets = 706,
	ChaperoneDataHasChanged = 800,
	ChaperoneUniverseHasChanged = 801,
	ChaperoneTempDataHasChanged = 802,
	ChaperoneSettingsHaveChanged = 803,
	SeatedZeroPoseReset = 804,
	ChaperoneFlushCache = 805,
	ChaperoneRoomSetupStarting = 806,
	ChaperoneRoomSetupFinished = 807,
	StandingZeroPoseReset = 808,
	AudioSettingsHaveChanged = 820,
	BackgroundSettingHasChanged = 850,
	CameraSettingsHaveChanged = 851,
	ReprojectionSettingHasChanged = 852,
	ModelSkinSettingsHaveChanged = 853,
	EnvironmentSettingsHaveChanged = 854,
	PowerSettingsHaveChanged = 855,
	EnableHomeAppSettingsHaveChanged = 856,
	SteamVRSectionSettingChanged = 857,
	LighthouseSectionSettingChanged = 858,
	NullSectionSettingChanged = 859,
	UserInterfaceSectionSettingChanged = 860,
	NotificationsSectionSettingChanged = 861,
	KeyboardSectionSettingChanged = 862,
	PerfSectionSettingChanged = 863,
	DashboardSectionSettingChanged = 864,
	WebInterfaceSectionSettingChanged = 865,
	TrackersSectionSettingChanged = 866,
	LastKnownSectionSettingChanged = 867,
	DismissedWarningsSectionSettingChanged = 868,
	GpuSpeedSectionSettingChanged = 869,
	WindowsMRSectionSettingChanged = 870,
	OtherSectionSettingChanged = 871,
	StatusUpdate = 900,
	WebInterface_InstallDriverCompleted = 950,
	MCImageUpdated = 1000,
	FirmwareUpdateStarted = 1100,
	FirmwareUpdateFinished = 1101,
	KeyboardClosed = 1200,
	KeyboardCharInput = 1201,
	KeyboardDone = 1202,
	ApplicationListUpdated = 1303,
	ApplicationMimeTypeLoad = 1304,
	ProcessConnected = 1306,
	ProcessDisconnected = 1307,
	Compositor_ChaperoneBoundsShown = 1410,
	Compositor_ChaperoneBoundsHidden = 1411,
	Compositor_DisplayDisconnected = 1412,
	Compositor_DisplayReconnected = 1413,
	Compositor_HDCPError = 1414,
	Compositor_ApplicationNotResponding = 1415,
	Compositor_ApplicationResumed = 1416,
	Compositor_OutOfVideoMemory = 1417,
	Compositor_DisplayModeNotSupported = 1418,
	Compositor_StageOverrideReady = 1419,
	Compositor_RequestDisconnectReconnect = 1420,
	TrackedCamera_StartVideoStream = 1500,
	TrackedCamera_StopVideoStream = 1501,
	TrackedCamera_PauseVideoStream = 1502,
	TrackedCamera_ResumeVideoStream = 1503,
	TrackedCamera_EditingSurface = 1550,
	PerformanceTest_EnableCapture = 1600,
	PerformanceTest_DisableCapture = 1601,
	PerformanceTest_FidelityLevel = 1602,
	MessageOverlay_Closed = 1650,
	MessageOverlayCloseRequested = 1651,
	Input_HapticVibration = 1700,
	Input_BindingLoadFailed = 1701,
	Input_BindingLoadSuccessful = 1702,
	Input_ActionManifestReloaded = 1703,
	Input_ActionManifestLoadFailed = 1704,
	Input_ProgressUpdate = 1705,
	Input_TrackerActivated = 1706,
	Input_BindingsUpdated = 1707,
	Input_BindingSubscriptionChanged = 1708,
	SpatialAnchors_PoseUpdated = 1800,
	SpatialAnchors_DescriptorUpdated = 1801,
	SpatialAnchors_RequestPoseUpdate = 1802,
	SpatialAnchors_RequestDescriptorUpdate = 1803,
	SystemReport_Started = 1900,
	Monitor_ShowHeadsetView = 2000,
	Monitor_HideHeadsetView = 2001,
	VendorSpecific_Reserved_Start = 10000,
	VendorSpecific_Reserved_End = 19999,
}

DeviceActivityLevel :: enum c.int {
	Unknown = -1,
	Idle = 0,
	UserInteraction = 1,
	UserInteraction_Timeout = 2,
	Standby = 3,
	Idle_Timeout = 4,
}

VRButtonId :: enum c.int {
	System = 0,
	ApplicationMenu = 1,
	Grip = 2,
	DPad_Left = 3,
	DPad_Up = 4,
	DPad_Right = 5,
	DPad_Down = 6,
	A = 7,
	ProximitySensor = 31,
	Axis0 = 32,
	Axis1 = 33,
	Axis2 = 34,
	Axis3 = 35,
	Axis4 = 36,
	SteamVR_Touchpad = 32,
	SteamVR_Trigger = 33,
	Dashboard_Back = 2,
	IndexController_A = 2,
	IndexController_B = 1,
	IndexController_JoyStick = 35,
	Max = 64,
}

VRMouseButton :: enum c.int {
	Left = 1,
	Right = 2,
	Middle = 4,
}

ShowUIType :: enum c.int {
	ControllerBinding = 0,
	ManageTrackers = 1,
	Pairing = 3,
	Settings = 4,
	DebugCommands = 5,
	FullControllerBinding = 6,
	ManageDrivers = 7,
}

HDCPError :: enum c.int {
	None = 0,
	LinkLost = 1,
	Tampered = 2,
	DeviceRevoked = 3,
	Unknown = 4,
}

VRComponentProperty :: enum c.int {
	IsStatic = 1,
	IsVisible = 2,
	IsTouched = 4,
	IsPressed = 8,
	IsScrolled = 16,
	IsHighlighted = 32,
}

VRInputError :: enum c.int {
	None = 0,
	NameNotFound = 1,
	WrongType = 2,
	InvalidHandle = 3,
	InvalidParam = 4,
	NoSteam = 5,
	MaxCapacityReached = 6,
	IPCError = 7,
	NoActiveActionSet = 8,
	InvalidDevice = 9,
	InvalidSkeleton = 10,
	InvalidBoneCount = 11,
	InvalidCompressedData = 12,
	NoData = 13,
	BufferTooSmall = 14,
	MismatchedActionManifest = 15,
	MissingSkeletonData = 16,
	InvalidBoneIndex = 17,
	InvalidPriority = 18,
	PermissionDenied = 19,
	InvalidRenderModel = 20,
}

VRSpatialAnchorError :: enum c.int {
	Success = 0,
	Internal = 1,
	UnknownHandle = 2,
	ArrayTooSmall = 3,
	InvalidDescriptorChar = 4,
	NotYetAvailable = 5,
	NotAvailableInThisUniverse = 6,
	PermanentlyUnavailable = 7,
	WrongDriver = 8,
	DescriptorTooLong = 9,
	Unknown = 10,
	NoRoomCalibration = 11,
	InvalidArgument = 12,
	UnknownDriver = 13,
}

HiddenAreaMeshType :: enum c.int {
	Standard = 0,
	Inverse = 1,
	LineLoop = 2,
	Max = 3,
}

VRControllerAxisType :: enum c.int {
	None = 0,
	TrackPad = 1,
	Joystick = 2,
	Trigger = 3,
}

VRControllerEventOutputType :: enum c.int {
	OSEvents = 0,
	VREvents = 1,
}

CollisionBoundsStyle :: enum c.int {
	Beginner = 0,
	Intermediate = 1,
	Squares = 2,
	Advanced = 3,
	None = 4,
	Count = 5,
}

VROverlayError :: enum c.int {
	None = 0,
	UnknownOverlay = 10,
	InvalidHandle = 11,
	PermissionDenied = 12,
	OverlayLimitExceeded = 13,
	WrongVisibilityType = 14,
	KeyTooLong = 15,
	NameTooLong = 16,
	KeyInUse = 17,
	WrongTransformType = 18,
	InvalidTrackedDevice = 19,
	InvalidParameter = 20,
	ThumbnailCantBeDestroyed = 21,
	ArrayTooSmall = 22,
	RequestFailed = 23,
	InvalidTexture = 24,
	UnableToLoadFile = 25,
	KeyboardAlreadyInUse = 26,
	NoNeighbor = 27,
	TooManyMaskPrimitives = 29,
	BadMaskPrimitive = 30,
	TextureAlreadyLocked = 31,
	TextureLockCapacityReached = 32,
	TextureNotLocked = 33,
	TimedOut = 34,
}

VRApplicationType :: enum c.int {
	Other = 0,
	Scene = 1,
	Overlay = 2,
	Background = 3,
	Utility = 4,
	VRMonitor = 5,
	SteamWatchdog = 6,
	Bootstrapper = 7,
	WebHelper = 8,
	OpenXRInstance = 9,
	OpenXRScene = 10,
	OpenXROverlay = 11,
	Prism = 12,
	RoomView = 13,
	Max = 14,
}

VRFirmwareError :: enum c.int {
	None = 0,
	Success = 1,
	Fail = 2,
}

VRNotificationError :: enum c.int {
	OK = 0,
	InvalidNotificationId = 100,
	NotificationQueueFull = 101,
	InvalidOverlayHandle = 102,
	SystemWithUserValueAlreadyExists = 103,
}

VRSkeletalMotionRange :: enum c.int {
	WithController = 0,
	WithoutController = 1,
}

VRSkeletalTrackingLevel :: enum c.int {
	Estimated = 0,
	Partial = 1,
	Full = 2,
	Count = 3,
	Max = 2,
}

VRInitError :: enum c.int {
	None = 0,
	Unknown = 1,
	Init_InstallationNotFound = 100,
	Init_InstallationCorrupt = 101,
	Init_VRClientDLLNotFound = 102,
	Init_FileNotFound = 103,
	Init_FactoryNotFound = 104,
	Init_InterfaceNotFound = 105,
	Init_InvalidInterface = 106,
	Init_UserConfigDirectoryInvalid = 107,
	Init_HmdNotFound = 108,
	Init_NotInitialized = 109,
	Init_PathRegistryNotFound = 110,
	Init_NoConfigPath = 111,
	Init_NoLogPath = 112,
	Init_PathRegistryNotWritable = 113,
	Init_AppInfoInitFailed = 114,
	Init_Retry = 115,
	Init_InitCanceledByUser = 116,
	Init_AnotherAppLaunching = 117,
	Init_SettingsInitFailed = 118,
	Init_ShuttingDown = 119,
	Init_TooManyObjects = 120,
	Init_NoServerForBackgroundApp = 121,
	Init_NotSupportedWithCompositor = 122,
	Init_NotAvailableToUtilityApps = 123,
	Init_Internal = 124,
	Init_HmdDriverIdIsNone = 125,
	Init_HmdNotFoundPresenceFailed = 126,
	Init_VRMonitorNotFound = 127,
	Init_VRMonitorStartupFailed = 128,
	Init_LowPowerWatchdogNotSupported = 129,
	Init_InvalidApplicationType = 130,
	Init_NotAvailableToWatchdogApps = 131,
	Init_WatchdogDisabledInSettings = 132,
	Init_VRDashboardNotFound = 133,
	Init_VRDashboardStartupFailed = 134,
	Init_VRHomeNotFound = 135,
	Init_VRHomeStartupFailed = 136,
	Init_RebootingBusy = 137,
	Init_FirmwareUpdateBusy = 138,
	Init_FirmwareRecoveryBusy = 139,
	Init_USBServiceBusy = 140,
	Init_VRWebHelperStartupFailed = 141,
	Init_TrackerManagerInitFailed = 142,
	Init_AlreadyRunning = 143,
	Init_FailedForVrMonitor = 144,
	Init_PropertyManagerInitFailed = 145,
	Init_WebServerFailed = 146,
	Init_IllegalTypeTransition = 147,
	Init_MismatchedRuntimes = 148,
	Init_InvalidProcessId = 149,
	Init_VRServiceStartupFailed = 150,
	Init_PrismNeedsNewDrivers = 151,
	Init_PrismStartupTimedOut = 152,
	Init_CouldNotStartPrism = 153,
	Init_PrismClientInitFailed = 154,
	Init_PrismClientStartFailed = 155,
	Init_PrismExitedUnexpectedly = 156,
	Init_BadLuid = 157,
	Init_NoServerForAppContainer = 158,
	Init_DuplicateBootstrapper = 159,
	Init_VRDashboardServicePending = 160,
	Init_VRDashboardServiceTimeout = 161,
	Init_VRDashboardServiceStopped = 162,
	Init_VRDashboardAlreadyStarted = 163,
	Init_VRDashboardCopyFailed = 164,
	Init_VRDashboardTokenFailure = 165,
	Init_VRDashboardEnvironmentFailure = 166,
	Init_VRDashboardPathFailure = 167,
	Driver_Failed = 200,
	Driver_Unknown = 201,
	Driver_HmdUnknown = 202,
	Driver_NotLoaded = 203,
	Driver_RuntimeOutOfDate = 204,
	Driver_HmdInUse = 205,
	Driver_NotCalibrated = 206,
	Driver_CalibrationInvalid = 207,
	Driver_HmdDisplayNotFound = 208,
	Driver_TrackedDeviceInterfaceUnknown = 209,
	Driver_HmdDriverIdOutOfBounds = 211,
	Driver_HmdDisplayMirrored = 212,
	Driver_HmdDisplayNotFoundLaptop = 213,
	Driver_PeerDriverNotInstalled = 214,
	Driver_WirelessHmdNotConnected = 215,
	IPC_ServerInitFailed = 300,
	IPC_ConnectFailed = 301,
	IPC_SharedStateInitFailed = 302,
	IPC_CompositorInitFailed = 303,
	IPC_MutexInitFailed = 304,
	IPC_Failed = 305,
	IPC_CompositorConnectFailed = 306,
	IPC_CompositorInvalidConnectResponse = 307,
	IPC_ConnectFailedAfterMultipleAttempts = 308,
	IPC_ConnectFailedAfterTargetExited = 309,
	IPC_NamespaceUnavailable = 310,
	Compositor_Failed = 400,
	Compositor_D3D11HardwareRequired = 401,
	Compositor_FirmwareRequiresUpdate = 402,
	Compositor_OverlayInitFailed = 403,
	Compositor_ScreenshotsInitFailed = 404,
	Compositor_UnableToCreateDevice = 405,
	Compositor_SharedStateIsNull = 406,
	Compositor_NotificationManagerIsNull = 407,
	Compositor_ResourceManagerClientIsNull = 408,
	Compositor_MessageOverlaySharedStateInitFailure = 409,
	Compositor_PropertiesInterfaceIsNull = 410,
	Compositor_CreateFullscreenWindowFailed = 411,
	Compositor_SettingsInterfaceIsNull = 412,
	Compositor_FailedToShowWindow = 413,
	Compositor_DistortInterfaceIsNull = 414,
	Compositor_DisplayFrequencyFailure = 415,
	Compositor_RendererInitializationFailed = 416,
	Compositor_DXGIFactoryInterfaceIsNull = 417,
	Compositor_DXGIFactoryCreateFailed = 418,
	Compositor_DXGIFactoryQueryFailed = 419,
	Compositor_InvalidAdapterDesktop = 420,
	Compositor_InvalidHmdAttachment = 421,
	Compositor_InvalidOutputDesktop = 422,
	Compositor_InvalidDeviceProvided = 423,
	Compositor_D3D11RendererInitializationFailed = 424,
	Compositor_FailedToFindDisplayMode = 425,
	Compositor_FailedToCreateSwapChain = 426,
	Compositor_FailedToGetBackBuffer = 427,
	Compositor_FailedToCreateRenderTarget = 428,
	Compositor_FailedToCreateDXGI2SwapChain = 429,
	Compositor_FailedtoGetDXGI2BackBuffer = 430,
	Compositor_FailedToCreateDXGI2RenderTarget = 431,
	Compositor_FailedToGetDXGIDeviceInterface = 432,
	Compositor_SelectDisplayMode = 433,
	Compositor_FailedToCreateNvAPIRenderTargets = 434,
	Compositor_NvAPISetDisplayMode = 435,
	Compositor_FailedToCreateDirectModeDisplay = 436,
	Compositor_InvalidHmdPropertyContainer = 437,
	Compositor_UpdateDisplayFrequency = 438,
	Compositor_CreateRasterizerState = 439,
	Compositor_CreateWireframeRasterizerState = 440,
	Compositor_CreateSamplerState = 441,
	Compositor_CreateClampToBorderSamplerState = 442,
	Compositor_CreateAnisoSamplerState = 443,
	Compositor_CreateOverlaySamplerState = 444,
	Compositor_CreatePanoramaSamplerState = 445,
	Compositor_CreateFontSamplerState = 446,
	Compositor_CreateNoBlendState = 447,
	Compositor_CreateBlendState = 448,
	Compositor_CreateAlphaBlendState = 449,
	Compositor_CreateBlendStateMaskR = 450,
	Compositor_CreateBlendStateMaskG = 451,
	Compositor_CreateBlendStateMaskB = 452,
	Compositor_CreateDepthStencilState = 453,
	Compositor_CreateDepthStencilStateNoWrite = 454,
	Compositor_CreateDepthStencilStateNoDepth = 455,
	Compositor_CreateFlushTexture = 456,
	Compositor_CreateDistortionSurfaces = 457,
	Compositor_CreateConstantBuffer = 458,
	Compositor_CreateHmdPoseConstantBuffer = 459,
	Compositor_CreateHmdPoseStagingConstantBuffer = 460,
	Compositor_CreateSharedFrameInfoConstantBuffer = 461,
	Compositor_CreateOverlayConstantBuffer = 462,
	Compositor_CreateSceneTextureIndexConstantBuffer = 463,
	Compositor_CreateReadableSceneTextureIndexConstantBuffer = 464,
	Compositor_CreateLayerGraphicsTextureIndexConstantBuffer = 465,
	Compositor_CreateLayerComputeTextureIndexConstantBuffer = 466,
	Compositor_CreateLayerComputeSceneTextureIndexConstantBuffer = 467,
	Compositor_CreateComputeHmdPoseConstantBuffer = 468,
	Compositor_CreateGeomConstantBuffer = 469,
	Compositor_CreatePanelMaskConstantBuffer = 470,
	Compositor_CreatePixelSimUBO = 471,
	Compositor_CreateMSAARenderTextures = 472,
	Compositor_CreateResolveRenderTextures = 473,
	Compositor_CreateComputeResolveRenderTextures = 474,
	Compositor_CreateDriverDirectModeResolveTextures = 475,
	Compositor_OpenDriverDirectModeResolveTextures = 476,
	Compositor_CreateFallbackSyncTexture = 477,
	Compositor_ShareFallbackSyncTexture = 478,
	Compositor_CreateOverlayIndexBuffer = 479,
	Compositor_CreateOverlayVertexBuffer = 480,
	Compositor_CreateTextVertexBuffer = 481,
	Compositor_CreateTextIndexBuffer = 482,
	Compositor_CreateMirrorTextures = 483,
	Compositor_CreateLastFrameRenderTexture = 484,
	Compositor_CreateMirrorOverlay = 485,
	Compositor_FailedToCreateVirtualDisplayBackbuffer = 486,
	Compositor_DisplayModeNotSupported = 487,
	Compositor_CreateOverlayInvalidCall = 488,
	Compositor_CreateOverlayAlreadyInitialized = 489,
	Compositor_FailedToCreateMailbox = 490,
	Compositor_WindowInterfaceIsNull = 491,
	Compositor_SystemLayerCreateInstance = 492,
	Compositor_SystemLayerCreateSession = 493,
	Compositor_CreateInverseDistortUVs = 494,
	Compositor_CreateBackbufferDepth = 495,
	VendorSpecific_UnableToConnectToOculusRuntime = 1000,
	VendorSpecific_WindowsNotInDevMode = 1001,
	VendorSpecific_OculusLinkNotEnabled = 1002,
	VendorSpecific_HmdFound_CantOpenDevice = 1101,
	VendorSpecific_HmdFound_UnableToRequestConfigStart = 1102,
	VendorSpecific_HmdFound_NoStoredConfig = 1103,
	VendorSpecific_HmdFound_ConfigTooBig = 1104,
	VendorSpecific_HmdFound_ConfigTooSmall = 1105,
	VendorSpecific_HmdFound_UnableToInitZLib = 1106,
	VendorSpecific_HmdFound_CantReadFirmwareVersion = 1107,
	VendorSpecific_HmdFound_UnableToSendUserDataStart = 1108,
	VendorSpecific_HmdFound_UnableToGetUserDataStart = 1109,
	VendorSpecific_HmdFound_UnableToGetUserDataNext = 1110,
	VendorSpecific_HmdFound_UserDataAddressRange = 1111,
	VendorSpecific_HmdFound_UserDataError = 1112,
	VendorSpecific_HmdFound_ConfigFailedSanityCheck = 1113,
	VendorSpecific_OculusRuntimeBadInstall = 1114,
	VendorSpecific_HmdFound_UnexpectedConfiguration_1 = 1115,
	Steam_SteamInstallationNotFound = 2000,
	LastError = 2001,
}

VRScreenshotType :: enum c.int {
	None = 0,
	Mono = 1,
	Stereo = 2,
	Cubemap = 3,
	MonoPanorama = 4,
	StereoPanorama = 5,
}

VRScreenshotPropertyFilenames :: enum c.int {
	Preview = 0,
	VR = 1,
}

VRTrackedCameraError :: enum c.int {
	None = 0,
	OperationFailed = 100,
	InvalidHandle = 101,
	InvalidFrameHeaderVersion = 102,
	OutOfHandles = 103,
	IPCFailure = 104,
	NotSupportedForThisDevice = 105,
	SharedMemoryFailure = 106,
	FrameBufferingFailure = 107,
	StreamSetupFailure = 108,
	InvalidGLTextureId = 109,
	InvalidSharedTextureHandle = 110,
	FailedToGetGLTextureId = 111,
	SharedTextureFailure = 112,
	NoFrameAvailable = 113,
	InvalidArgument = 114,
	InvalidFrameBufferSize = 115,
}

VRTrackedCameraFrameLayout :: enum c.int {
	Mono = 1,
	Stereo = 2,
	VerticalLayout = 16,
	HorizontalLayout = 32,
}

VRTrackedCameraFrameType :: enum c.int {
	Distorted = 0,
	Undistorted = 1,
	MaximumUndistorted = 2,
	MAX_CAMERA_FRAME_TYPES = 3,
}

VRDistortionFunctionType :: enum c.int {
	None = 0,
	FTheta = 1,
	Extended_FTheta = 2,
	MAX_DISTORTION_FUNCTION_TYPES = 3,
}

VSync :: enum c.int {
	None = 0,
	WaitRender = 1,
	NoWaitRender = 2,
}

VRMuraCorrectionMode :: enum c.int {
	EVRMuraCorrectionMode_Default = 0,
	EVRMuraCorrectionMode_NoCorrection = 1,
}

Imu_OffScaleFlags :: enum c.int {
	AccelX = 1,
	AccelY = 2,
	AccelZ = 4,
	GyroX = 8,
	GyroY = 16,
	GyroZ = 32,
}

VRApplicationError :: enum c.int {
	None = 0,
	AppKeyAlreadyExists = 100,
	NoManifest = 101,
	NoApplication = 102,
	InvalidIndex = 103,
	UnknownApplication = 104,
	IPCFailed = 105,
	ApplicationAlreadyRunning = 106,
	InvalidManifest = 107,
	InvalidApplication = 108,
	LaunchFailed = 109,
	ApplicationAlreadyStarting = 110,
	LaunchInProgress = 111,
	OldApplicationQuitting = 112,
	TransitionAborted = 113,
	IsTemplate = 114,
	SteamVRIsExiting = 115,
	BufferTooSmall = 200,
	PropertyNotSet = 201,
	UnknownProperty = 202,
	InvalidParameter = 203,
	NotImplemented = 300,
}

VRApplicationProperty :: enum c.int {
	Name_String = 0,
	LaunchType_String = 11,
	WorkingDirectory_String = 12,
	BinaryPath_String = 13,
	Arguments_String = 14,
	URL_String = 15,
	Description_String = 50,
	NewsURL_String = 51,
	ImagePath_String = 52,
	Source_String = 53,
	ActionManifestURL_String = 54,
	IsDashboardOverlay_Bool = 60,
	IsTemplate_Bool = 61,
	IsInstanced_Bool = 62,
	IsInternal_Bool = 63,
	WantsCompositorPauseInStandby_Bool = 64,
	IsHidden_Bool = 65,
	LastLaunchTime_Uint64 = 70,
}

VRSceneApplicationState :: enum c.int {
	None = 0,
	Starting = 1,
	Quitting = 2,
	Running = 3,
	Waiting = 4,
}

ChaperoneCalibrationState :: enum c.int {
	OK = 1,
	Warning = 100,
	Warning_BaseStationMayHaveMoved = 101,
	Warning_BaseStationRemoved = 102,
	Warning_SeatedBoundsInvalid = 103,
	Error = 200,
	Error_BaseStationUninitialized = 201,
	Error_BaseStationConflict = 202,
	Error_PlayAreaInvalid = 203,
	Error_CollisionBoundsInvalid = 204,
}

ChaperoneConfigFile :: enum c.int {
	EChaperoneConfigFile_Live = 1,
	EChaperoneConfigFile_Temp = 2,
}

ChaperoneImportFlags :: enum c.int {
	EChaperoneImport_BoundsOnly = 1,
}

VRCompositorError :: enum c.int {
	None = 0,
	RequestFailed = 1,
	IncompatibleVersion = 100,
	DoNotHaveFocus = 101,
	InvalidTexture = 102,
	IsNotSceneApplication = 103,
	TextureIsOnWrongDevice = 104,
	TextureUsesUnsupportedFormat = 105,
	SharedTexturesNotSupported = 106,
	IndexOutOfRange = 107,
	AlreadySubmitted = 108,
	InvalidBounds = 109,
	AlreadySet = 110,
}

VRCompositorTimingMode :: enum c.int {
	Implicit = 0,
	Explicit_RuntimePerformsPostPresentHandoff = 1,
	Explicit_ApplicationPerformsPostPresentHandoff = 2,
}

VROverlayInputMethod :: enum c.int {
	None = 0,
	Mouse = 1,
}

VROverlayTransformType :: enum c.int {
	Invalid = -1,
	Absolute = 0,
	TrackedDeviceRelative = 1,
	SystemOverlay = 2,
	TrackedComponent = 3,
	Cursor = 4,
	DashboardTab = 5,
	DashboardThumb = 6,
	Mountable = 7,
	Projection = 8,
}

VROverlayFlags :: enum c.int {
	NoDashboardTab = 8,
	SendVRDiscreteScrollEvents = 64,
	SendVRTouchpadEvents = 128,
	ShowTouchPadScrollWheel = 256,
	TransferOwnershipToInternalProcess = 512,
	SideBySide_Parallel = 1024,
	SideBySide_Crossed = 2048,
	Panorama = 4096,
	StereoPanorama = 8192,
	SortWithNonSceneOverlays = 16384,
	VisibleInDashboard = 32768,
	MakeOverlaysInteractiveIfVisible = 65536,
	SendVRSmoothScrollEvents = 131072,
	ProtectedContent = 262144,
	HideLaserIntersection = 524288,
	WantsModalBehavior = 1048576,
	IsPremultiplied = 2097152,
	IgnoreTextureAlpha = 4194304,
}

VRMessageOverlayResponse :: enum c.int {
	ButtonPress_0 = 0,
	ButtonPress_1 = 1,
	ButtonPress_2 = 2,
	ButtonPress_3 = 3,
	CouldntFindSystemOverlay = 4,
	CouldntFindOrCreateClientOverlay = 5,
	ApplicationQuit = 6,
}

GamepadTextInputMode :: enum c.int {
	Normal = 0,
	Password = 1,
	Submit = 2,
}

GamepadTextInputLineMode :: enum c.int {
	SingleLine = 0,
	MultipleLines = 1,
}

VROverlayIntersectionMaskPrimitiveType :: enum c.int {
	Rectangle = 0,
	Circle = 1,
}

KeyboardFlags :: enum c.int {
	Minimal = 1,
	Modal = 2,
}

DeviceType :: enum c.int {
	Invalid = -1,
	DirectX11 = 0,
	Vulkan = 1,
}

HeadsetViewMode_t :: enum c.int {
	Left = 0,
	Right = 1,
	Both = 2,
}

VRRenderModelError :: enum c.int {
	None = 0,
	Loading = 100,
	NotSupported = 200,
	InvalidArg = 300,
	InvalidModel = 301,
	NoShapes = 302,
	MultipleShapes = 303,
	TooManyVertices = 304,
	MultipleTextures = 305,
	BufferTooSmall = 306,
	NotEnoughNormals = 307,
	NotEnoughTexCoords = 308,
	InvalidTexture = 400,
}

VRRenderModelTextureFormat :: enum c.int {
	RGBA8_SRGB = 0,
	BC2 = 1,
	BC4 = 2,
	BC7 = 3,
	BC7_SRGB = 4,
	RGBA16_FLOAT = 5,
}

VRNotificationType :: enum c.int {
	Transient = 0,
	Persistent = 1,
	Transient_SystemWithUserValue = 2,
}

VRNotificationStyle :: enum c.int {
	None = 0,
	Application = 100,
	Contact_Disabled = 200,
	Contact_Enabled = 201,
	Contact_Active = 202,
}

VRSettingsError :: enum c.int {
	None = 0,
	IPCFailed = 1,
	WriteFailed = 2,
	ReadFailed = 3,
	JsonParseFailed = 4,
	UnsetSettingHasNoDefault = 5,
}

VRScreenshotError :: enum c.int {
	None = 0,
	RequestFailed = 1,
	IncompatibleVersion = 100,
	NotFound = 101,
	BufferTooSmall = 102,
	ScreenshotAlreadyInProgress = 108,
}

VRSkeletalTransformSpace :: enum c.int {
	Model = 0,
	Parent = 1,
}

VRSkeletalReferencePose :: enum c.int {
	BindPose = 0,
	OpenHand = 1,
	Fist = 2,
	GripLimit = 3,
}

VRFinger :: enum c.int {
	Thumb = 0,
	Index = 1,
	Middle = 2,
	Ring = 3,
	Pinky = 4,
	Count = 5,
}

VRFingerSplay :: enum c.int {
	Thumb_Index = 0,
	Index_Middle = 1,
	Middle_Ring = 2,
	Ring_Pinky = 3,
	Count = 4,
}

VRSummaryType :: enum c.int {
	FromAnimation = 0,
	FromDevice = 1,
}

VRInputFilterCancelType :: enum c.int {
	Timers = 0,
	Momentum = 1,
}

VRInputStringBits :: enum c.int {
	Hand = 1,
	ControllerType = 2,
	InputSource = 4,
	All = -1,
}

IOBufferError :: enum c.int {
	Success = 0,
	OperationFailed = 100,
	InvalidHandle = 101,
	InvalidArgument = 102,
	PathExists = 103,
	PathDoesNotExist = 104,
	Permission = 105,
}

IOBufferMode :: enum c.int {
	Read = 1,
	Write = 2,
	Create = 512,
}

VRDebugError :: enum c.int {
	Success = 0,
	BadParameter = 1,
}

PropertyWriteType :: enum c.int {
	PropertyWrite_Set = 0,
	PropertyWrite_Erase = 1,
	PropertyWrite_SetError = 2,
}

BlockQueueError :: enum c.int {
	None = 0,
	QueueAlreadyExists = 1,
	QueueNotFound = 2,
	BlockNotAvailable = 3,
	InvalidHandle = 4,
	InvalidParam = 5,
	ParamMismatch = 6,
	InternalError = 7,
	AlreadyInitialized = 8,
	OperationIsServerOnly = 9,
	TooManyConnections = 10,
}

BlockQueueReadType :: enum c.int {
	Latest = 0,
	New = 1,
	Next = 2,
}

BlockQueueCreationFlag :: enum c.int {
	BlockQueueFlag_OwnerIsReader = 1,
}

