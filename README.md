<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

**macos_window_utils** is a Flutter package that provides a set of methods for modifying the `NSWindow` of a Flutter application on macOS. With this package, you can easily customize the appearance and behavior of your app's window, including the title bar, transparency effects, shadow, and more.

## Features

**macos_window_utils** offers, among other things, the following features:

+ Methods to set the application window's material.
+ methods to enter/exit fullscreen mode or (un)zoom the window.
+ Methods to mark a window as “document edited”.
+ Methods to set represented filenames and URLs.
+ Methods to hide/show the window's title.
+ Methods to enable/disable the full-size content view.
+ Methods to show/hide and enable/disable the window's traffic light buttons.
+ A method to set the window's alpha value.
+ Methods to add a toolbar to the window and set its style.
+ A method to add a subtitle to the window.
+ Methods to make the window ignore mouse events.
+ A method that makes the window fully transparent (with no blur effect).
+ Methods to enable/disable the window's shadow.
+ Methods and widgets to add, remove, and modify visual effect subviews.

Additionally, the package ships with an example project that showcases the plugin's features via an intuitive searchable user interface:

<img width="857" alt="screenshot of example project" src="https://user-images.githubusercontent.com/86920182/209587744-b21f2cd1-07a4-43ee-99c8-7cce1d89482d.png">

## Getting started

Open the `macos/Runner.xcworkspace` folder of your project using Xcode, press ⇧ + ⌘ + O and search for `MainFlutterWindow.swift`.

Insert `import macos_window_utils` at the top of the file.
Then, replace the code above the `super.awakeFromNib()`-line with the following code:

```swift
let windowFrame = self.frame
let macOSWindowUtilsViewController = MacOSWindowUtilsViewController()
self.contentViewController = macOSWindowUtilsViewController
self.setFrame(windowFrame, display: true)

/* Initialize the macos_window_utils plugin */
MainFlutterWindowManipulator.start(mainFlutterWindow: self)

RegisterGeneratedPlugins(registry: macOSWindowUtilsViewController.flutterViewController)
```

Assuming you're starting with the default configuration, the finished code should look something like this:

```diff
import Cocoa
import FlutterMacOS
+import macos_window_utils

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
-   let flutterViewController = FlutterViewController.init()
-   let windowFrame = self.frame
-   self.contentViewController = flutterViewController
-   self.setFrame(windowFrame, display: true)

-   RegisterGeneratedPlugins(registry: flutterViewController)
    
+   let windowFrame = self.frame
+   let macOSWindowUtilsViewController = MacOSWindowUtilsViewController()
+   self.contentViewController = macOSWindowUtilsViewController
+   self.setFrame(windowFrame, display: true)

+   /* Initialize the macos_window_utils plugin */
+   MainFlutterWindowManipulator.start(mainFlutterWindow: self)

+   RegisterGeneratedPlugins(registry: macOSWindowUtilsViewController.flutterViewController)

    super.awakeFromNib()
  }
}
```

Now press ⇧ + ⌘ + O once more and search for `Runner.xcodeproj`. Go to `info` > `Deployment Target` and set the `macOS Deployment Target` to `10.13` or above.

Depending on your use case, you may want to extend the area of the window that Flutter can draw to to the entire window, such that you are able to draw onto the window's title bar as well (for example when you're only trying to make the sidebar transparent while the rest of the window is meant to stay opaque).

To do so, enable the full-size content view with the following Dart code:

```dart
WindowManipulator.makeTitlebarTransparent();
WindowManipulator.enableFullSizeContentView();
```

When you decide to do this, it is recommended to wrap your application (or parts of it) in a `TitlebarSafeArea` widget as follows:

```dart
TitlebarSafeArea(
  child: YourApp(),
)
```

This ensures that your app is not covered by the window's title bar.

Additionally, it may be worth considering to split your sidebar and your main view into multiple `NSVisualEffectView`'s inside your
app. This is because macOS has a feature called “wallpaper tinting,” which is enabled by default. This feature allows windows to
blend in with the desktop wallpaper:

<img width="1680" alt="macos_wallpaper_tinting" src="https://user-images.githubusercontent.com/86920182/209585269-bcdcd7fe-1077-4a90-b11e-2cf44e17e479.png">

To achieve the same effect in your Flutter application, you can set the window's material to `NSVisualEffectViewMaterial.windowBackground` and wrap
your sidebar widget with a `TransparentMacOSSidebar` widget like so:

```dart
TransparentMacOSSidebar(
  child: YourSidebarWidget(),
)
```

**Note:** The widget will automatically resize the `NSVisualEffectView` when a resize is detected in the widget's `build` method.
If you are animating your sidebar's size using a `TweenAnimationBuilder`, please make sure that the `TransparentMacOSSidebar` widget
is built *within* the `TweenAnimationBuilder`'s `build` method, in order to guarantee that a rebuild is triggered when the size
changes. For reference, there is a working example in the `transparent_sidebar_and_content.dart` file of the `example` project.

## Usage

Initialize the plugin as follows:
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManipulator.initialize();
  runApp(MyApp());
}
```

Afterwards, call any method of the `WindowManipulator` class to manipulate your application's window.

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
