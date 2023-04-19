package openvr

import vk "vendor:vulkan"
import D3D11 "vendor:directx/d3d11"
import D3D12 "vendor:directx/d3d12"

HmdMatrix34 :: struct {
	m: [3][4]f32,
}

HmdMatrix33 :: struct {
	m: [3][3]f32,
}

HmdMatrix44 :: struct {
	m: [4][4]f32,
}

HmdVector3 :: struct {
	v: [3]f32,
}

HmdVector4 :: struct {
	v: [4]f32,
}

HmdVector3d :: struct {
	v: [3]f64,
}

HmdVector2 :: struct {
	v: [2]f32,
}

HmdQuaternion :: struct {
	w: f64,
	x: f64,
	y: f64,
	z: f64,
}

HmdQuaternionf :: struct {
	w: f32,
	x: f32,
	y: f32,
	z: f32,
}

HmdColor :: struct {
	r: f32,
	g: f32,
	b: f32,
	a: f32,
}

HmdQuad :: struct {
	vCorners: [4]HmdVector3,
}

HmdRect2 :: struct {
	vTopLeft: HmdVector2,
	vBottomRight: HmdVector2,
}

BoneTransform :: struct {
	position: HmdVector4,
	orientation: HmdQuaternionf,
}

DistortionCoordinates :: struct {
	rfRed: [2]f32,
	rfGreen: [2]f32,
	rfBlue: [2]f32,
}

Texture :: struct {
	handle: rawptr,
	eType: TextureType,
	eColorSpace: ColorSpace,
}

TrackedDevicePose :: struct {
	mDeviceToAbsoluteTracking: HmdMatrix34,
	vVelocity: HmdVector3,
	vAngularVelocity: HmdVector3,
	eTrackingResult: TrackingResult,
	bPoseIsValid: bool,
	bDeviceIsConnected: bool,
}

TextureBounds :: struct {
	uMin: f32,
	vMin: f32,
	uMax: f32,
	vMax: f32,
}

TextureWithPose :: struct {
	mDeviceToAbsoluteTracking: HmdMatrix34,
}

TextureDepthInfo :: struct {
	handle: rawptr,
	mProjection: HmdMatrix44,
	vRange: HmdVector2,
}

TextureWithDepth :: struct {
	depth: TextureDepthInfo,
}

TextureWithPoseAndDepth :: struct {
	depth: TextureDepthInfo,
}

VulkanTextureData :: struct {
	nImage: u64,
	pDevice: vk.Device,
	pPhysicalDevice: vk.PhysicalDevice,
	pInstance: vk.Instance,
	pQueue: vk.Queue,
	nQueueFamilyIndex: u32,
	nWidth: u32,
	nHeight: u32,
	nFormat: u32,
	nSampleCount: u32,
}

VulkanTextureArrayData :: struct {
	unArrayIndex: u32,
	unArraySize: u32,
}

D3D12TextureData :: struct {
	pResource: ^D3D12.IResource,
	pCommandQueue: ^D3D12.ICommandQueue,
	nNodeMask: u32,
}

Event_Controller :: struct {
	button: u32,
}

Event_Mouse :: struct {
	x: f32,
	y: f32,
	button: u32,
}

Event_Scroll :: struct {
	xdelta: f32,
	ydelta: f32,
	unused: u32,
	viewportscale: f32,
}

Event_TouchPadMove :: struct {
	bFingerDown: bool,
	flSecondsFingerDown: f32,
	fValueXFirst: f32,
	fValueYFirst: f32,
	fValueXRaw: f32,
	fValueYRaw: f32,
}

Event_Notification :: struct {
	ulUserValue: u64,
	notificationId: u32,
}

Event_Process :: struct {
	pid: u32,
	oldPid: u32,
	bForced: bool,
	bConnectionLost: bool,
}

Event_Overlay :: struct {
	overlayHandle: u64,
	devicePath: u64,
	memoryBlockId: u64,
}

Event_Status :: struct {
	statusState: u32,
}

Event_Keyboard :: struct {
	cNewInput: [8]u8,
	uUserValue: u64,
}

Event_Ipd :: struct {
	ipdMeters: f32,
}

Event_Chaperone :: struct {
	nPreviousUniverse: u64,
	nCurrentUniverse: u64,
}

Event_Reserved :: struct {
	reserved0: u64,
	reserved1: u64,
	reserved2: u64,
	reserved3: u64,
	reserved4: u64,
	reserved5: u64,
}

Event_PerformanceTest :: struct {
	nFidelityLevel: u32,
}

Event_SeatedZeroPoseReset :: struct {
	bResetBySystemMenu: bool,
}

Event_Screenshot :: struct {
	handle: u32,
	type: u32,
}

Event_ScreenshotProgress :: struct {
	progress: f32,
}

Event_ApplicationLaunch :: struct {
	pid: u32,
	unArgsHandle: u32,
}

Event_EditingCameraSurface :: struct {
	overlayHandle: u64,
	nVisualMode: u32,
}

Event_MessageOverlay :: struct {
	unVRMessageOverlayResponse: u32,
}

Event_Property :: struct {
	container: PropertyContainerHandle,
	prop: TrackedDeviceProperty,
}

Event_HapticVibration :: struct {
	containerHandle: u64,
	componentHandle: u64,
	fDurationSeconds: f32,
	fFrequency: f32,
	fAmplitude: f32,
}

Event_WebConsole :: struct {
	webConsoleHandle: WebConsoleHandle,
}

Event_InputBindingLoad :: struct {
	ulAppContainer: PropertyContainerHandle,
	pathMessage: u64,
	pathUrl: u64,
	pathControllerType: u64,
}

Event_InputActionManifestLoad :: struct {
	pathAppKey: u64,
	pathMessage: u64,
	pathMessageParam: u64,
	pathManifestPath: u64,
}

Event_SpatialAnchor :: struct {
	unHandle: SpatialAnchorHandle,
}

Event_ProgressUpdate :: struct {
	ulApplicationPropertyContainer: u64,
	pathDevice: u64,
	pathInputSource: u64,
	pathProgressAction: u64,
	pathIcon: u64,
	fProgress: f32,
}

Event_ShowUI :: struct {
	eType: ShowUIType,
}

Event_ShowDevTools :: struct {
	nBrowserIdentifier: i32,
}

Event_HDCPError :: struct {
	eCode: HDCPError,
}

Event_Data :: struct #raw_union {
	reserved: Event_Reserved,
	controller: Event_Controller,
	mouse: Event_Mouse,
	scroll: Event_Scroll,
	process: Event_Process,
	notification: Event_Notification,
	overlay: Event_Overlay,
	status: Event_Status,
	keyboard: Event_Keyboard,
	ipd: Event_Ipd,
	chaperone: Event_Chaperone,
	performanceTest: Event_PerformanceTest,
	touchPadMove: Event_TouchPadMove,
	seatedZeroPoseReset: Event_SeatedZeroPoseReset,
	screenshot: Event_Screenshot,
	screenshotProgress: Event_ScreenshotProgress,
	applicationLaunch: Event_ApplicationLaunch,
	cameraSurface: Event_EditingCameraSurface,
	messageOverlay: Event_MessageOverlay,
	property: Event_Property,
	hapticVibration: Event_HapticVibration,
	webConsole: Event_WebConsole,
	inputBinding: Event_InputBindingLoad,
	actionManifest: Event_InputActionManifestLoad,
	spatialAnchor: Event_SpatialAnchor,
	progressUpdate: Event_ProgressUpdate,
	showUi: Event_ShowUI,
	showDevTools: Event_ShowDevTools,
	hdcpError: Event_HDCPError,
}

Event :: struct {
	eventType: u32,
	trackedDeviceIndex: TrackedDeviceIndex,
	eventAgeSeconds: f32,
	data: Event_Data,
}

RenderModel_ComponentState :: struct {
	mTrackingToComponentRenderModel: HmdMatrix34,
	mTrackingToComponentLocal: HmdMatrix34,
	uProperties: ComponentProperties,
}

HiddenAreaMesh :: struct {
	pVertexData: ^HmdVector2,
	unTriangleCount: u32,
}

ControllerAxis :: struct {
	x: f32,
	y: f32,
}

ControllerState001 :: struct {
	unPacketNum: u32,
	ulButtonPressed: u64,
	ulButtonTouched: u64,
	rAxis: [5]ControllerAxis,
}

CameraVideoStreamFrameHeader :: struct {
	eFrameType: TrackedCameraFrameType,
	nWidth: u32,
	nHeight: u32,
	nBytesPerPixel: u32,
	nFrameSequence: u32,
	trackedDevicePose: TrackedDevicePose,
	ulFrameExposureTime: u64,
}

Compositor_FrameTiming :: struct {
	nSize: u32,
	nFrameIndex: u32,
	nNumFramePresents: u32,
	nNumMisPresented: u32,
	nNumDroppedFrames: u32,
	nReprojectionFlags: u32,
	flSystemTimeInSeconds: f64,
	flPreSubmitGpuMs: f32,
	flPostSubmitGpuMs: f32,
	flTotalRenderGpuMs: f32,
	flCompositorRenderGpuMs: f32,
	flCompositorRenderCpuMs: f32,
	flCompositorIdleCpuMs: f32,
	flClientFrameIntervalMs: f32,
	flPresentCallCpuMs: f32,
	flWaitForPresentCpuMs: f32,
	flSubmitFrameMs: f32,
	flWaitGetPosesCalledMs: f32,
	flNewPosesReadyMs: f32,
	flNewFrameReadyMs: f32,
	flCompositorUpdateStartMs: f32,
	flCompositorUpdateEndMs: f32,
	flCompositorRenderStartMs: f32,
	HmdPose: TrackedDevicePose,
	nNumVSyncsReadyForUse: u32,
	nNumVSyncsToFirstView: u32,
}

Compositor_BenchmarkResults :: struct {
	flMegaPixelsPerSecond: f32,
	flHmdRecommendedMegaPixelsPerSecond: f32,
}

DriverDirectMode_FrameTiming :: struct {
	nSize: u32,
	nNumFramePresents: u32,
	nNumMisPresented: u32,
	nNumDroppedFrames: u32,
	nReprojectionFlags: u32,
}

ImuSample :: struct {
	fSampleTime: f64,
	vAccel: HmdVector3d,
	vGyro: HmdVector3d,
	unOffScaleFlags: u32,
}

AppOverrideKeys :: struct {
	pchKey: cstring,
	pchValue: cstring,
}

Compositor_CumulativeStats :: struct {
	nPid: u32,
	nNumFramePresents: u32,
	nNumDroppedFrames: u32,
	nNumReprojectedFrames: u32,
	nNumFramePresentsOnStartup: u32,
	nNumDroppedFramesOnStartup: u32,
	nNumReprojectedFramesOnStartup: u32,
	nNumLoading: u32,
	nNumFramePresentsLoading: u32,
	nNumDroppedFramesLoading: u32,
	nNumReprojectedFramesLoading: u32,
	nNumTimedOut: u32,
	nNumFramePresentsTimedOut: u32,
	nNumDroppedFramesTimedOut: u32,
	nNumReprojectedFramesTimedOut: u32,
}

Compositor_StageRenderSettings :: struct {
	PrimaryColor: HmdColor,
	SecondaryColor: HmdColor,
	flVignetteInnerRadius: f32,
	flVignetteOuterRadius: f32,
	flFresnelStrength: f32,
	bBackfaceCulling: bool,
	bGreyscale: bool,
	bWireframe: bool,
}

OverlayIntersectionParams :: struct {
	vSource: HmdVector3,
	vDirection: HmdVector3,
	eOrigin: TrackingUniverseOrigin,
}

OverlayIntersectionResults :: struct {
	vPoint: HmdVector3,
	vNormal: HmdVector3,
	vUVs: HmdVector2,
	fDistance: f32,
}

IntersectionMaskRectangle :: struct {
	flTopLeftX: f32,
	flTopLeftY: f32,
	flWidth: f32,
	flHeight: f32,
}

IntersectionMaskCircle :: struct {
	flCenterX: f32,
	flCenterY: f32,
	flRadius: f32,
}

OverlayIntersectionMaskPrimitive_Data :: struct #raw_union {
	Rectangle: IntersectionMaskRectangle,
	Circle: IntersectionMaskCircle,
}

OverlayIntersectionMaskPrimitive :: struct {
	nPrimitiveType: OverlayIntersectionMaskPrimitiveType,
	Primitive: OverlayIntersectionMaskPrimitive_Data,
}

OverlayProjection :: struct {
	fLeft: f32,
	fRight: f32,
	fTop: f32,
	fBottom: f32,
}

OverlayView :: struct {
	overlayHandle: OverlayHandle,
	texture: Texture,
	textureBounds: TextureBounds,
}

VulkanDevice :: struct {
	pInstance: vk.Instance,
	pDevice: vk.Device,
	pPhysicalDevice: vk.PhysicalDevice,
	pQueue: vk.Queue,
	uQueueFamilyIndex: u32,
}

NativeDevice :: struct {
	handle: rawptr,
	eType: DeviceType,
}

RenderModel_Vertex :: struct {
	vPosition: HmdVector3,
	vNormal: HmdVector3,
	rfTextureCoord: [2]f32,
}

RenderModel_TextureMap :: struct {
	unWidth: u16,
	unHeight: u16,
	rubTextureMapData: [^]u8,
	format: RenderModelTextureFormat,
	unMipLevels: u16,
}

RenderModel :: struct {
	rVertexData: ^RenderModel_Vertex,
	unVertexCount: u32,
	rIndexData: ^u16,
	unTriangleCount: u32,
	diffuseTextureId: TextureID,
}

RenderModel_ControllerMode_State :: struct {
	bScrollWheelVisible: bool,
}

NotificationBitmap :: struct {
	pImageData: rawptr,
	nWidth: i32,
	nHeight: i32,
	nBytesPerPixel: i32,
}

CVRSettingHelper :: struct {
	pSettings: ^ISettings,
}

InputAnalogActionData :: struct {
	bActive: bool,
	activeOrigin: InputValueHandle,
	x: f32,
	y: f32,
	z: f32,
	deltaX: f32,
	deltaY: f32,
	deltaZ: f32,
	fUpdateTime: f32,
}

InputDigitalActionData :: struct {
	bActive: bool,
	activeOrigin: InputValueHandle,
	bState: bool,
	bChanged: bool,
	fUpdateTime: f32,
}

InputPoseActionData :: struct {
	bActive: bool,
	activeOrigin: InputValueHandle,
	pose: TrackedDevicePose,
}

InputSkeletalActionData :: struct {
	bActive: bool,
	activeOrigin: InputValueHandle,
}

InputOriginInfo :: struct {
	devicePath: InputValueHandle,
	trackedDeviceIndex: TrackedDeviceIndex,
	rchRenderModelComponentName: [128]u8,
}

InputBindingInfo :: struct {
	rchDevicePathName: [128]u8,
	rchInputPathName: [128]u8,
	rchModeName: [128]u8,
	rchSlotName: [128]u8,
	rchInputSourceType: [32]u8,
}

ActiveActionSet :: struct {
	ulActionSet: ActionSetHandle,
	ulRestrictedToDevice: InputValueHandle,
	ulSecondaryActionSet: ActionSetHandle,
	unPadding: u32,
	nPriority: i32,
}

SkeletalSummaryData :: struct {
	flFingerCurl: [5]f32,
	flFingerSplay: [4]f32,
}

SpatialAnchorPose :: struct {
	mAnchorToAbsoluteTracking: HmdMatrix34,
}

COpenVRContext :: struct {
	pVRSystem: ^ISystem,
	pVRChaperone: ^IChaperone,
	pVRChaperoneSetup: ^IChaperoneSetup,
	pVRCompositor: ^ICompositor,
	pVRHeadsetView: ^IHeadsetView,
	pVROverlay: ^IOverlay,
	pVROverlayView: ^IOverlayView,
	pVRResources: ^IResources,
	pVRRenderModels: ^IRenderModels,
	pVRExtendedDisplay: ^IExtendedDisplay,
	pVRSettings: ^ISettings,
	pVRApplications: ^IApplications,
	pVRTrackedCamera: ^ITrackedCamera,
	pVRScreenshots: ^IScreenshots,
	pVRDriverManager: ^IDriverManager,
	pVRInput: ^IInput,
	pVRIOBuffer: ^IIOBuffer,
	pVRSpatialAnchors: ^ISpatialAnchors,
	pVRDebug: ^IDebug,
	pVRNotifications: ^INotifications,
}

PropertyWrite :: struct {
	prop: TrackedDeviceProperty,
	writeType: PropertyWriteType,
	eSetError: TrackedPropertyError,
	pvBuffer: rawptr,
	unBufferSize: u32,
	unTag: PropertyTypeTag,
	eError: TrackedPropertyError,
}

PropertyRead :: struct {
	prop: TrackedDeviceProperty,
	pvBuffer: rawptr,
	unBufferSize: u32,
	unTag: PropertyTypeTag,
	unRequiredBufferSize: u32,
	eError: TrackedPropertyError,
}

CVRPropertyHelpers :: struct {
	pProperties: ^IProperties,
}

PathWrite :: struct {
	ulPath: PathHandle,
	writeType: PropertyWriteType,
	eSetError: TrackedPropertyError,
	pvBuffer: rawptr,
	unBufferSize: u32,
	unTag: PropertyTypeTag,
	eError: TrackedPropertyError,
	pszPath: cstring,
}

PathRead :: struct {
	ulPath: PathHandle,
	pvBuffer: rawptr,
	unBufferSize: u32,
	unTag: PropertyTypeTag,
	unRequiredBufferSize: u32,
	eError: TrackedPropertyError,
	pszPath: cstring,
}

