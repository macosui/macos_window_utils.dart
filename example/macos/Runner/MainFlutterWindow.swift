import Cocoa
import FlutterMacOS
import macos_window_utils

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let windowFrame = self.frame
        let blurryContainerViewController = BlurryContainerViewController() // new
        self.contentViewController = blurryContainerViewController // new
        self.setFrame(windowFrame, display: true)
        
        /* Initialize the macos_window_utils plugin */
        MainFlutterWindowManipulator.start(mainFlutterWindow: self) // new
        
        RegisterGeneratedPlugins(registry: blurryContainerViewController.flutterViewController) // new

        super.awakeFromNib()
    }
}
