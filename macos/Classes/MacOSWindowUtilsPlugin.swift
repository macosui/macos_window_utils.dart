import Cocoa
import FlutterMacOS

public class MacOSWindowUtilsPlugin: NSObject, FlutterPlugin {
    private var registrar: FlutterPluginRegistrar!;
    private var channel: FlutterMethodChannel!
    
    private static func printUnsupportedMacOSVersionWarning() {
        print("Warning: Transparency effects are not supported for your macOS Deployment Target.")
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.adrian_samoticha/macos_window_utils", binaryMessenger: registrar.messenger)
        let instance = MacOSWindowUtilsPlugin(registrar, channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public init(_ registrar: FlutterPluginRegistrar, _ channel: FlutterMethodChannel) {
        super.init()
        self.registrar = registrar
        self.channel = channel
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let methodName: String = call.method
        let args: [String: Any] = call.arguments as? [String: Any] ?? [:]
        
        switch (methodName) {
        case "initialize":
            if #available(macOS 10.14, *) {
                let material = EffectIDToMaterialConverter.getMaterialFromEffectID(effectID: 0)
                
                MainFlutterWindowManipulator.setEffect(material: material)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            result(true)
            break
            
        case "setEffect":
            if #available(macOS 10.14, *) {
                let effectID = args["effect"] as! NSNumber
                let material = EffectIDToMaterialConverter.getMaterialFromEffectID(effectID: effectID)
                
                MainFlutterWindowManipulator.setEffect(material: material)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            result(true)
            break
            
        case "hideWindowControls":
            MainFlutterWindowManipulator.hideZoomButton()
            MainFlutterWindowManipulator.hideMiniaturizeButton()
            MainFlutterWindowManipulator.hideCloseButton()
            result(true)
            break
            
        case "showWindowControls":
            MainFlutterWindowManipulator.showZoomButton()
            MainFlutterWindowManipulator.showMiniaturizeButton()
            MainFlutterWindowManipulator.showCloseButton()
            result(true)
            break
            
        case "enterFullscreen":
            MainFlutterWindowManipulator.enterFullscreen()
            result(true)
            break
            
        case "exitFullscreen":
            MainFlutterWindowManipulator.exitFullscreen()
            result(true)
            break
            
        case "overrideMacOSBrightness":
            if #available(macOS 10.14, *) {
                let dark = args["dark"] as! Bool
                
                MainFlutterWindowManipulator.setAppearance(dark: dark)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            result(true)
            break
            
        case "setDocumentEdited":
            MainFlutterWindowManipulator.setDocumentEdited()
            result(true)
            break
            
        case "setDocumentUnedited":
            MainFlutterWindowManipulator.setDocumentUnedited()
            result(true)
            break
            
        case "setRepresentedFile":
            let filename = args["filename"] as! String
            
            MainFlutterWindowManipulator.setRepresentedFilename(filename: filename)
            result(true)
            break
            
        case "setRepresentedURL":
            let url = args["url"] as! String
            
            MainFlutterWindowManipulator.setRepresentedFilename(filename: url)
            result(true)
            break
            
        case "getTitlebarHeight":
            let titlebarHeight = MainFlutterWindowManipulator.getTitlebarHeight() as NSNumber
            result(titlebarHeight)
            break
            
        case "hideTitle":
            MainFlutterWindowManipulator.hideTitle()
            result(true)
            break

        case "showTitle":
            MainFlutterWindowManipulator.showTitle()
            result(true)
            break

        case "makeTitlebarTransparent":
            MainFlutterWindowManipulator.makeTitlebarTransparent()
            result(true)
            break

        case "makeTitlebarOpaque":
            MainFlutterWindowManipulator.makeTitlebarOpaque()
            result(true)
            break

        case "enableFullSizeContentView":
            MainFlutterWindowManipulator.enableFullSizeContentView()
            result(true)
            break

        case "disableFullSizeContentView":
            MainFlutterWindowManipulator.disableFullSizeContentView()
            result(true)
            break

        case "zoomWindow":
            MainFlutterWindowManipulator.zoomWindow()
            result(true)
            break

        case "unzoomWindow":
            MainFlutterWindowManipulator.unzoomWindow()
            result(true)
            break

        case "isWindowZoomed":
            let isWindowZoomed = MainFlutterWindowManipulator.isWindowZoomed()
            result(isWindowZoomed)
            break

        case "isWindowFullscreened":
            let isWindowFullscreened = MainFlutterWindowManipulator.isWindowFullscreened()
            result(isWindowFullscreened)
            break

        case "hideZoomButton":
            MainFlutterWindowManipulator.hideZoomButton()
            result(true)
            break

        case "showZoomButton":
            MainFlutterWindowManipulator.showZoomButton()
            result(true)
            break

        case "hideMiniaturizeButton":
            MainFlutterWindowManipulator.hideMiniaturizeButton()
            result(true)
            break

        case "showMiniaturizeButton":
            MainFlutterWindowManipulator.showMiniaturizeButton()
            result(true)
            break

        case "hideCloseButton":
            MainFlutterWindowManipulator.hideCloseButton()
            result(true)
            break

        case "showCloseButton":
            MainFlutterWindowManipulator.showCloseButton()
            result(true)
            break

        case "enableZoomButton":
            MainFlutterWindowManipulator.enableZoomButton()
            result(true)
            break

        case "disableZoomButton":
            MainFlutterWindowManipulator.disableZoomButton()
            result(true)
            break

        case "enableMiniaturizeButton":
            MainFlutterWindowManipulator.enableMiniaturizeButton()
            result(true)
            break

        case "disableMiniaturizeButton":
            MainFlutterWindowManipulator.disableMiniaturizeButton()
            result(true)
            break

        case "enableCloseButton":
            MainFlutterWindowManipulator.enableCloseButton()
            result(true)
            break

        case "disableCloseButton":
            MainFlutterWindowManipulator.disableCloseButton()
            result(true)
            break

        case "isWindowInLiveResize":
            let isWindowInLiveResize = MainFlutterWindowManipulator.isWindowInLiveResize()
            result(isWindowInLiveResize)
            break

        case "setWindowAlphaValue":
            let alphaValue = args["value"] as! NSNumber
            MainFlutterWindowManipulator.setWindowAlphaValue(alphaValue: alphaValue as! CGFloat)
            result(true)
            break

        case "isWindowVisible":
            let isWindowVisible = MainFlutterWindowManipulator.isWindowVisible()
            result(isWindowVisible)
            break
            
        case "setWindowBackgroundColorToDefaultColor":
            MainFlutterWindowManipulator.setWindowBackgroundColorToDefaultColor()
            result(true)
            break
            
        case "setWindowBackgroundColorToClear":
            MainFlutterWindowManipulator.setWindowBackgroundColorToClear()
            result(true)
            break
            
        case "setBlurViewState":
            let blurViewStateString = args["state"] as! String
            let state = blurViewStateString == "active"   ? NSVisualEffectView.State.active :
                        blurViewStateString == "inactive" ? NSVisualEffectView.State.inactive :
                                                            NSVisualEffectView.State.followsWindowActiveState
            MainFlutterWindowManipulator.setBlurViewState(state: state)
            result(true)
            break
            
        case "addVisualEffectSubview":
            let visualEffectSubview = VisualEffectSubview()
            let visualEffectSubviewId = MainFlutterWindowManipulator.addVisualEffectSubview(visualEffectSubview)
            
            if #available(macOS 10.14, *) {
                let properties = VisualEffectSubviewProperties.fromArgs(args)
                properties.applyToVisualEffectSubview(visualEffectSubview)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            
            result(visualEffectSubviewId)
            break
            
        case "updateVisualEffectSubviewProperties":
            let visualEffectSubviewId = args["visualEffectSubviewId"] as! UInt
            let visualEffectSubview = MainFlutterWindowManipulator.getVisualEffectSubview(visualEffectSubviewId)
            
            if (visualEffectSubview != nil) {
                if #available(macOS 10.14, *) {
                    let properties = VisualEffectSubviewProperties.fromArgs(args)
                    properties.applyToVisualEffectSubview(visualEffectSubview!)
                } else {
                    MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
                }
            }
            
            result(visualEffectSubview != nil)
            break
            
        case "removeVisualEffectSubview":
            let visualEffectSubviewId = args["visualEffectSubviewId"] as! UInt
            MainFlutterWindowManipulator.removeVisualEffectSubview(visualEffectSubviewId)
            
            result(true)
            break
            
        case "addToolbar":
            MainFlutterWindowManipulator.addToolbar()
            
            result(true)
            break
            
        case "removeToolbar":
            MainFlutterWindowManipulator.removeToolbar()
            
            result(true)
            break
            
        case "setToolbarStyle":
            let toolbarStyleName = args["toolbarStyle"] as! String
            
            if #available(macOS 11.0, *) {
                let toolbarStyle = ToolbarStyleNameToEnumConverter.getToolbarStyleFromName(name: toolbarStyleName)
                
                if toolbarStyle != nil {
                    MainFlutterWindowManipulator.setToolbarStyle(toolbarStyle: toolbarStyle!)
                }
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }
            
            result(true)
            break
            
        case "enableShadow":
            MainFlutterWindowManipulator.enableShadow()

            result(true)
            break

        case "disableShadow":
            MainFlutterWindowManipulator.disableShadow()

            result(true)
            break

        case "invalidateShadows":
            MainFlutterWindowManipulator.invalidateShadows()

            result(true)
            break

        case "addEmptyMaskImage":
            MainFlutterWindowManipulator.addEmptyMaskImage()

            result(true)
            break

        case "removeMaskImage":
            MainFlutterWindowManipulator.removeMaskImage()

            result(true)
            break
            
        case "ignoreMouseEvents":
            MainFlutterWindowManipulator.ignoreMouseEvents()

            result(true)
            break
            
        case "acknowledgeMouseEvents":
            MainFlutterWindowManipulator.acknowledgeMouseEvents()

            result(true)
            break
            
        case "setSubtitle":
            let subtitle = args["subtitle"] as! String
            if #available(macOS 11.0, *) {
                MainFlutterWindowManipulator.setSubtitle(subtitle)
            } else {
                MacOSWindowUtilsPlugin.printUnsupportedMacOSVersionWarning()
            }

            result(true)
            break
            
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }
}