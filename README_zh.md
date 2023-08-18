[English](README.md) | 简体中文

**macos_window_utils** 是一个 Flutter 包，它提供了一组方法来修改 macOS 上 Flutter 应用程序的 `NSWindow`。使用此包，您可以轻松自定义应用程序窗口的外观和行为，包括标题栏、透明效果、阴影等。

## 特点

**macos_window_utils** 提供了以下功能：

+ 设置应用程序窗口材质。
+ 进入/退出全屏模式或（取消）缩放窗口。
+ 将一个窗口标记为“文档已编辑”。
+ 设置代表的文件名和 URL。
+ 隐藏/显示窗口的标题。
+ 启用/禁用全尺寸内容视图。
+ 显示/隐藏和启用/禁用窗口的交通灯按钮（就左上角三个按钮）。
+ 设置窗口的透明度。
+ 添加工具栏到窗口并设置其样式。
+ 为窗口添加副标题。
+ 使窗口忽略鼠标事件。
+ 使窗口完全透明（没有模糊效果）。
+ 启用/禁用窗口的阴影。
+ 添加、删除和修改视觉效果子视图的方法和小部件。
+ 设置窗口的级别以及在其级别内重新排序窗口。
+ 修改窗口样式遮罩（style mask）。
+ 一个抽象的 `NSWindowDelegate` 类，可用于检测 `NSWindow` 事件，例如窗口调整大小、移动、暴露和最小化。
+ 一个 `NSAppPresentationOptions` 类，允许修改窗口的全屏演示选项。

此外，该包还附带了一个示例项目，通过直观的可搜索用户界面展示了插件的功能：

<img width="857" alt="screenshot of example project" src="https://user-images.githubusercontent.com/86920182/209587744-b21f2cd1-07a4-43ee-99c8-7cce1d89482d.png">

## 入门

首先，通过以下命令安装包：

```
flutter pub add macos_window_utils
```

然后，使用 Xcode 打开项目的 `macos/Runner.xcworkspace` 文件夹，按 ⇧ + ⌘ + O 并搜索 `Runner.xcodeproj`。

前往 `Info` > `Deployment Target` 并将 `macOS Deployment Target` 设置为 `10.14.6` 或更高。然后，打开项目的 `Podfile`（如果它没有在 Xcode 中显示，您可以通过 VS Code 在项目的 `macos` 目录中找到它）并将在第一行的最小部署版本设置为 `10.14.6` 或更高：

```podspec
platform :osx, '10.14.6'
```

根据你的需求，您可能希望将 Flutter 可以绘制的窗口区域扩展到整个窗口，这样您就可以在窗口的标题栏上绘制（例如，当您只想让侧边栏透明，而窗口的其他部分保持不透明时）。

为此，请使用以下 Dart 代码启用全尺寸内容视图：

```dart
WindowManipulator.makeTitlebarTransparent();
WindowManipulator.enableFullSizeContentView();
```

当决定这样做时，建议将应用程序（或其部分）包装在 `TitlebarSafeArea` 小部件中，如下所示：

```dart
TitlebarSafeArea(
  child: YourApp(),
)
```

这样可以确保您的应用程序不会被窗口的标题栏覆盖。

此外，您可能应该考虑在应用程序中将侧边栏和主视图拆分为多个 `NSVisualEffectView`。这是因为 macOS 有一个名为 “wallpaper tinting” 的功能，处于默认启动的状态。此功能允许窗口与桌面壁纸融合（blend）：

<img width="1680" alt="macos_wallpaper_tinting" src="https://user-images.githubusercontent.com/86920182/209585269-bcdcd7fe-1077-4a90-b11e-2cf44e17e479.png">

要在 Flutter 应用程序中实现相同的效果，您可以将窗口的材质设置为 `NSVisualEffectViewMaterial.windowBackground`，并使用 `TransparentMacOSSidebar` 小部件包装侧边栏小部件，如下所示：

```dart
TransparentMacOSSidebar(
  child: YourSidebarWidget(),
)
```

**注意**：当检测到在一个部件的 `build` 方法中检测到调整大小时，该部件将自动调整 `NSVisualEffectView` 的大小。如果您正在使用 `TweenAnimationBuilder` 以动画的方式调整侧边栏的大小，请确保 `TransparentMacOSSidebar` 小部件**在** `TweenAnimationBuilder` 的 `build` 方法中构建，以确保在大小更改时触发重建。可以参考在 `example` 中 `transparent_sidebar_and_content.dart` 的示例。

## 用法

如下所示初始化插件：

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManipulator.initialize();
  runApp(MyApp());
}
```

然后，调用 `WindowManipulator` 类的任何方法来操作您的应用程序窗口。

### 使用 `NSWindowDelegate`

`NSWindowDelegate` 可用于监听 `NSWindow` 事件，例如窗口调整大小、移动、暴露和最小化。为了使用它，请首先确保在您的 `WindowManipulator.initialize` 调用中将 `enableWindowDelegate` 设置为 `true`：

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 默认情况下，enableWindowDelegate 设置为 false，以确保与其他插件兼容。如果您希望使用 NSWindowDelegate，请将其设置为 true。
  await WindowManipulator.initialize(enableWindowDelegate: true);
  runApp(MyApp());
}
```

然后，创建一个扩展它的类：

```dart
class _MyDelegate extends NSWindowDelegate {
  @override
  void windowDidEnterFullScreen() {
    print('已进入全屏模式');
    
    super.windowDidEnterFullScreen();
  }
}
```

此类重写 `NSWindowDelegate` 的 `windowDidEnterFullScreen` 方法以响应它。

以下方法目前由 `NSWindowDelegate` 支持：
<details>
  <summary>支持的方法</summary>

  - 管理 Sheets
     - `windowWillBeginSheet`
     - `windowDidEndSheet`
  - 调整窗口大小
     - `windowWillResize`
     - `windowDidResize`
     - `windowWillStartLiveResize`
     - `windowDidEndLiveResize`
  - 最小化窗口
     - `windowWillMiniaturize`
     - `windowDidMiniaturize`
     - `windowDidDeminiaturize`
  - 缩放窗口
     - `windowWillUseStandardFrame`
     - `windowShouldZoom`
  - 管理全屏展示
     - `windowWillEnterFullScreen`
     - `windowDidEnterFullScreen`
     - `windowWillExitFullScreen`
     - `windowDidExitFullScreen`
  - 移动窗口
     - `windowWillMove`
     - `windowDidMove`
     - `windowDidChangeScreen`
     - `windowDidChangeScreenProfile`
     - `windowDidChangeBackingProperties`
  - 关闭窗口
     - `windowShouldClose`
     - `windowWillClose`
  - 管理 Key 状态（Managing Key Status）
     - `windowDidBecomeKey`
     - `windowDidResignKey`
  - 管理主要状态
     - `windowDidBecomeMain`
     - `windowDidResignMain`
  - 暴露窗口
     - `windowDidExpose`
  - 管理遮挡状态
     - `windowDidChangeOcclusionState`
  -  管理版本浏览器中的演示（ Managing Presentation in Version Browsers ）
     - `windowWillEnterVersionBrowser`
     - `windowDidEnterVersionBrowser`
     - `windowWillExitVersionBrowser`
     - `windowDidExitVersionBrowser`

</details>

<br>

然后，通过 `WindowManipulator.addNSWindowDelegate` 方法添加一个实例：

```dart
 final delegate = _MyDelegate();
 final handle = WindowManipulator.addNSWindowDelegate(delegate);
```

`WindowManipulator.addNSWindowDelegate` 返回一个 `NSWindowDelegateHandle`，它可以用来稍后再次删除此 `NSWindowDelegate`：

```dart
handle.removeFromHandler();
```

### 使用 `NSAppPresentationOptions`

假设我们希望在窗口处于全屏模式时自动隐藏工具栏。使用 `NSAppPresentationOptions` 可以按如下方式完成：

```dart
// 创建 NSAppPresentationOptions 实例。
final options = NSAppPresentationOptions.from({
  // fullScreen 需要始终作为全屏选项存在。
  NSAppPresentationOption.fullScreen,

  // 在全屏模式下自动隐藏工具栏。
  NSAppPresentationOption.autoHideToolbar,

  // autoHideToolbar 必须与 autoHideMenuBar 一起使用。
  NSAppPresentationOption.autoHideMenuBar,

  // autoHideMenuBar 必须与 autoHideDock 或 hideDock 之一 一起使用。
  NSAppPresentationOption.autoHideDock,
});

// 将选项应用为全屏选项。
options.applyAsFullScreenPresentationOptions();
```

**注意：**`NSAppPresentationOptions` 使用 `NSWindow` 的委托来更改窗口的全屏选项。因此，`enableWindowDelegate` 需要在您的 `WindowManipulator.initialize` 调用中设置为 `true` 才能正常工作。

## 许可证

MIT License
