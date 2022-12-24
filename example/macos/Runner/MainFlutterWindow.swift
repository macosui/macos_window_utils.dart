import Cocoa
import FlutterMacOS
import macos_window_utils

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let windowFrame = self.frame
        let macOSWindowUtilsViewController = MacOSWindowUtilsViewController() // new
        self.contentViewController = macOSWindowUtilsViewController // new
        self.setFrame(windowFrame, display: true)
        
        /* Initialize the macos_window_utils plugin */
        MainFlutterWindowManipulator.start(mainFlutterWindow: self) // new
        
        RegisterGeneratedPlugins(registry: macOSWindowUtilsViewController.flutterViewController) // new

        super.awakeFromNib()
    }
}
