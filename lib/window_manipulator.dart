import 'dart:async';

import 'package:flutter/services.dart';
import 'package:macos_window_utils/macos/ns_visual_effect_view_state.dart';
import 'package:macos_window_utils/macos/ns_window_level.dart';
import 'package:macos_window_utils/macos/ns_window_style_mask.dart';
import 'package:macos_window_utils/macos/ns_window_toolbar_style.dart';
import 'package:macos_window_utils/macos/visual_effect_view_properties.dart';
import 'package:macos_window_utils/macos/ns_visual_effect_view_material.dart';

/// Class that provides methods to manipulate the application's window.
class WindowManipulator {
  static final _methodChannel =
      const MethodChannel('com.adrian_samoticha/macos_window_utils');
  static final _completer = Completer<void>();

  /// Initializes the [WindowManipulator] class.
  ///
  /// Example:
  /// ```dart
  /// Future<void> main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await WindowManipulator.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initialize() async {
    await _methodChannel.invokeMethod('initialize');
    _completer.complete();
  }

  /// Modifies the window's subview's material property.
  ///
  /// Examples:
  ///
  /// ```dart
  /// await WindowManipulator.setMaterial(
  ///   material: NSVisualEffectViewMaterial.windowBackground,
  /// );
  /// ```
  ///
  /// ```dart
  /// await WindowManipulator.setMaterial(
  ///   material: NSVisualEffectViewMaterial.sidebar,
  /// );
  /// ```
  static Future<void> setMaterial(NSVisualEffectViewMaterial material) async {
    await _completer.future;
    await _methodChannel.invokeMethod(
      'setMaterial',
      {'material': material.index},
    );
  }

  /// Makes the Flutter window fullscreen.
  static Future<void> enterFullscreen() async {
    await _methodChannel.invokeMethod('enterFullscreen');
  }

  /// Restores the Flutter window back to normal from fullscreen mode.
  static Future<void> exitFullscreen() async {
    await _methodChannel.invokeMethod('exitFullscreen');
  }

  /// Gets the height of the titlebar.
  ///
  /// This value is used to determine the [[TitlebarSafeArea]] widget.
  /// If the full-size content view is enabled, this value will be the height of
  /// the titlebar. If the full-size content view is disabled, this value will
  /// be 0.
  static Future<double> getTitlebarHeight() async {
    await _completer.future;
    return await _methodChannel.invokeMethod('getTitlebarHeight');
  }

  /// Sets the document to be edited.
  ///
  /// This changes the appearance of the close button on the titlebar:
  ///
  /// <img width="78" alt="image" src="https://user-images.githubusercontent.com/86920182/209436903-0a6c1f5a-4ab6-454f-a37d-78a5d699f3df.png">
  static Future<void> setDocumentEdited() async {
    await _completer.future;
    await _methodChannel.invokeMethod('setDocumentEdited');
  }

  /// Sets the document to be unedited.
  static Future<void> setDocumentUnedited() async {
    await _completer.future;
    await _methodChannel.invokeMethod('setDocumentUnedited');
  }

  /// Sets the represented file of the window.
  static Future<void> setRepresentedFilename(String filename) async {
    await _completer.future;
    await _methodChannel.invokeMethod('setRepresentedFile', {
      'filename': filename,
    });
  }

  /// Sets the represented URL of the window.
  static Future<void> setRepresentedUrl(String url) async {
    await _completer.future;
    await _methodChannel.invokeMethod('setRepresentedURL', {
      'url': url,
    });
  }

  /// Hides the titlebar of the window.
  static Future<void> hideTitle() async {
    await _completer.future;
    await _methodChannel.invokeMethod('hideTitle');
  }

  /// Shows the titlebar of the window.
  static Future<void> showTitle() async {
    await _completer.future;
    await _methodChannel.invokeMethod('showTitle');
  }

  /// Makes the window's titlebar transparent.
  static Future<void> makeTitlebarTransparent() async {
    await _completer.future;
    await _methodChannel.invokeMethod('makeTitlebarTransparent');
  }

  /// Makes the window's titlebar opaque.
  static Future<void> makeTitlebarOpaque() async {
    await _completer.future;
    await _methodChannel.invokeMethod('makeTitlebarOpaque');
  }

  /// Enables the window's full-size content view.
  ///
  /// This expands the area that Flutter can draw to to fill the entire window.
  /// It is recommended to enable the full-size content view when making
  /// the titlebar transparent.
  static Future<void> enableFullSizeContentView() async {
    await _completer.future;
    await _methodChannel.invokeMethod('enableFullSizeContentView');
  }

  /// Disables the window's full-size content view.
  static Future<void> disableFullSizeContentView() async {
    await _completer.future;
    await _methodChannel.invokeMethod('disableFullSizeContentView');
  }

  /// Zooms the window.
  static Future<void> zoomWindow() async {
    await _completer.future;
    await _methodChannel.invokeMethod('zoomWindow');
  }

  /// Unzooms the window.
  static Future<void> unzoomWindow() async {
    await _completer.future;
    await _methodChannel.invokeMethod('unzoomWindow');
  }

  /// Returns if the window is zoomed.
  static Future<bool> isWindowZoomed() async {
    await _completer.future;
    return await _methodChannel.invokeMethod('isWindowZoomed');
  }

  /// Returns if the window is fullscreened.
  static Future<bool> isWindowFullscreened() async {
    await _completer.future;
    return await _methodChannel.invokeMethod('isWindowFullscreened');
  }

  /// Hides the window's zoom button.
  static Future<void> hideZoomButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('hideZoomButton');
  }

  /// Shows the window's zoom button.
  ///
  /// The zoom button is visible by default.
  static Future<void> showZoomButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('showZoomButton');
  }

  /// Hides the window's miniaturize button.
  static Future<void> hideMiniaturizeButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('hideMiniaturizeButton');
  }

  /// Shows the window's miniaturize button.
  ///
  /// The miniaturize button is visible by default.
  static Future<void> showMiniaturizeButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('showMiniaturizeButton');
  }

  /// Hides the window's close button.
  static Future<void> hideCloseButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('hideCloseButton');
  }

  /// Shows the window's close button.
  ///
  /// The close button is visible by default.
  static Future<void> showCloseButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('showCloseButton');
  }

  /// Enables the window's zoom button.
  ///
  /// The zoom button is enabled by default.
  static Future<void> enableZoomButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('enableZoomButton');
  }

  /// Disables the window's zoom button.
  static Future<void> disableZoomButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('disableZoomButton');
  }

  /// Enables the window's miniaturize button.
  ///
  /// The miniaturize button is enabled by default.
  static Future<void> enableMiniaturizeButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('enableMiniaturizeButton');
  }

  /// Disables the window's miniaturize button.
  static Future<void> disableMiniaturizeButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('disableMiniaturizeButton');
  }

  /// Enables the window's close button.
  ///
  /// The close button is enabled by default.
  static Future<void> enableCloseButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('enableCloseButton');
  }

  /// Disables the window's close button.
  static Future<void> disableCloseButton() async {
    await _completer.future;
    await _methodChannel.invokeMethod('disableCloseButton');
  }

  /// Gets whether the window is currently being resized by the user.
  static Future<bool> isWindowInLiveResize() async {
    await _completer.future;
    return await _methodChannel.invokeMethod('isWindowInLiveResize');
  }

  /// Sets the window's alpha value.
  static Future<void> setWindowAlphaValue(double value) async {
    await _completer.future;
    await _methodChannel.invokeMethod('setWindowAlphaValue', <String, dynamic>{
      'value': value,
    });
  }

  /// Gets if the window is visible.
  static Future<bool> isWindowVisible() async {
    await _completer.future;
    return await _methodChannel.invokeMethod('isWindowVisible');
  }

  /// Sets the window background color to the default (opaque) window color.
  ///
  /// This method mainly affects the window's titlebar.
  static Future<void> setWindowBackgroundColorToDefaultColor() async {
    await _completer.future;
    await _methodChannel.invokeMethod('setWindowBackgroundColorToDefaultColor');
  }

  /// Sets the window background color to clear.
  static Future<void> setWindowBackgroundColorToClear() async {
    await _completer.future;
    await _methodChannel.invokeMethod('setWindowBackgroundColorToClear');
  }

  /// Sets the `NSVisualEffectView` state.
  static Future<void> setNSVisualEffectViewState(
      NSVisualEffectViewState state) async {
    await _completer.future;
    await _methodChannel
        .invokeMethod('setNSVisualEffectViewState', <String, dynamic>{
      'state': state.name,
    });
  }

  /// Adds a visual effect subview to the application's window and returns its
  /// ID.
  static Future<int> addVisualEffectSubview(
      VisualEffectSubviewProperties properties) async {
    await _completer.future;
    return await _methodChannel.invokeMethod(
        'addVisualEffectSubview', properties.toMap());
  }

  /// Updates the properties of a visual effect subview.
  static Future<void> updateVisualEffectSubviewProperties(
      int visualEffectSubviewId,
      VisualEffectSubviewProperties properties) async {
    await _completer.future;
    await _methodChannel
        .invokeMethod('updateVisualEffectSubviewProperties', <String, dynamic>{
      'visualEffectSubviewId': visualEffectSubviewId,
      ...properties.toMap(),
    });
  }

  /// Removes a visual effect subview from the application's window.
  static Future<void> removeVisualEffectSubview(
      int visualEffectSubviewId) async {
    await _completer.future;
    await _methodChannel
        .invokeMethod('removeVisualEffectSubview', <String, dynamic>{
      'visualEffectSubviewId': visualEffectSubviewId,
    });
  }

  /// Overrides the brightness setting of the window.
  static Future<void> overrideMacOSBrightness({
    required bool dark,
  }) async {
    await _completer.future;
    await _methodChannel.invokeMethod(
      'overrideMacOSBrightness',
      {
        'dark': dark,
      },
    );
  }

  /// Adds a toolbar to the window.
  static Future<void> addToolbar() async {
    await _completer.future;
    await _methodChannel.invokeMethod('addToolbar');
  }

  /// Removes the window's toolbar.
  static Future<void> removeToolbar() async {
    await _completer.future;
    await _methodChannel.invokeMethod('removeToolbar');
  }

  /// Sets the window's toolbar style.
  ///
  /// For this method to have an effect, the window needs to have had a toolbar
  /// added with the `addToolbar` method beforehand.
  ///
  /// Usage example:
  /// ```dart
  /// WindowManipulator.addToolbar();
  /// WindowManipulator.setToolbarStyle(NSWindowToolbarStyle.unified);
  /// ```
  static Future<void> setToolbarStyle(
      {required NSWindowToolbarStyle toolbarStyle}) async {
    await _completer.future;
    await _methodChannel.invokeMethod('setToolbarStyle', {
      'toolbarStyle': toolbarStyle.name,
    });
  }

  /// Enables the window's shadow.
  static Future<void> enableShadow() async {
    await _completer.future;
    await _methodChannel.invokeMethod('enableShadow');
  }

  /// Disables the window's shadow.
  static Future<void> disableShadow() async {
    await _completer.future;
    await _methodChannel.invokeMethod('disableShadow');
  }

  /// Invalidates the window's shadow.
  ///
  /// This is a fairly technical method and is included here for
  /// completeness' sake. Normally, it should not be necessary to use it.
  static Future<void> invalidateShadows() async {
    await _completer.future;
    await _methodChannel.invokeMethod('invalidateShadows');
  }

  /// Adds an empty mask image to the window's view.
  ///
  /// This will effectively disable the `NSVisualEffectView`'s effect.
  ///
  /// **Warning:** It is recommended to disable the window's shadow using
  /// `WindowManipulator.disableShadow()` when using this method. Keeping the
  /// shadow enabled when using an empty mask image can cause visual artifacts
  /// and performance issues.
  static Future<void> addEmptyMaskImage() async {
    await _completer.future;
    await _methodChannel.invokeMethod('addEmptyMaskImage');
  }

  /// Removes the window's mask image.
  static Future<void> removeMaskImage() async {
    await _completer.future;
    await _methodChannel.invokeMethod('removeMaskImage');
  }

  /// Makes a window fully transparent (with no blur effect).
  ///
  /// This is a convenience method which executes:
  /// ```dart
  /// setWindowBackgroundColorToClear();
  /// makeTitlebarTransparent();
  /// addEmptyMaskImage();
  /// disableShadow();
  /// ```
  ///
  /// **Warning:** When the window is fully transparent, its highlight effect
  /// (the thin white line at the top of the window) is still visible. This is
  /// considered a bug and may change in a future version.
  static void makeWindowFullyTransparent() {
    setWindowBackgroundColorToClear();
    makeTitlebarTransparent();
    addEmptyMaskImage();
    disableShadow();
  }

  /// Makes the window ignore mouse events.
  ///
  /// This method can be used to make parts of the window click-through, which
  /// may be desirable when used in conjunction with
  /// `makeWindowFullyTransparent()`.
  static Future<void> ignoreMouseEvents() async {
    await _completer.future;
    await _methodChannel.invokeMethod('ignoreMouseEvents');
  }

  /// Makes the window acknowledge mouse events.
  ///
  /// This method can be used to make parts of the window click-through, which
  /// may be desirable when used in conjunction with
  /// `makeWindowFullyTransparent()`.
  static Future<void> acknowledgeMouseEvents() async {
    await _completer.future;
    await _methodChannel.invokeMethod('acknowledgeMouseEvents');
  }

  /// Sets the subtitle of the window.
  ///
  /// To remove the subtitle, pass an empty string to this method.
  static Future<void> setSubtitle(String subtitle) async {
    await _completer.future;
    await _methodChannel.invokeMethod('setSubtitle', {
      'subtitle': subtitle,
    });
  }

  /// Sets the level of the window.
  ///
  /// Each level in the list groups windows within it in front of those in all
  /// preceding groups. Floating windows, for example, appear in front of all
  /// normal-level windows. When a window enters a new level, it’s ordered in
  /// front of all its peers in that level.
  ///
  /// Usage examples:
  ///
  /// ```dart
  /// // Set the window to appear in front of all normal-level windows:
  /// WindowManipulator.setLevel(NSWindowLevel.floating);
  ///
  /// // Set the window to appear behind all normal-level windows:
  /// WindowManipulator.setLevel(NSWindowLevel.normal.withOffset(-1));
  ///
  /// // Reset the window's level to the default value:
  /// WindowManipulator.setLevel(NSWindowLevel.normal);
  /// ```
  static Future<void> setLevel(NSWindowLevel level) async {
    await _completer.future;
    await _methodChannel.invokeMethod('setLevel', {
      'base': level.baseName,
      'offset': level.offset,
    });
  }

  /// Removes the window from the screen list, which hides the window.
  static Future<void> orderOut() async {
    await _completer.future;
    await _methodChannel.invokeMethod('orderOut');
  }

  /// Moves the window to the back of its level in the screen list, without
  /// changing either the key window or the main window.
  static Future<void> orderBack() async {
    await _completer.future;
    await _methodChannel.invokeMethod('orderBack');
  }

  /// Moves the window to the front of its level in the screen list, without
  /// changing either the key window or the main window.
  static Future<void> orderFront() async {
    await _completer.future;
    await _methodChannel.invokeMethod('orderFront');
  }

  /// Moves the window to the front of its level, even if its application isn't
  /// active, without changing either the key window or the main window.
  static Future<void> orderFrontRegardless() async {
    await _completer.future;
    await _methodChannel.invokeMethod('orderFrontRegardless');
  }

  /// Enables a flag that describes the window's current style, such as if it's
  /// resizable or in full-screen mode.
  ///
  /// Usage example:
  /// ```dart
  /// WindowManipulator.removeFromStyleMask()
  /// ```
  static Future<void> insertIntoStyleMask(NSWindowStyleMask styleMask) async {
    await _completer.future;
    await _methodChannel.invokeMethod('insertIntoStyleMask', {
      'styleMask': styleMask.name,
    });
  }

  /// Disables a flag that describes the window's current style, such as if it's
  /// resizable or in full-screen mode.
  static Future<void> removeFromStyleMask(NSWindowStyleMask styleMask) async {
    await _completer.future;
    await _methodChannel.invokeMethod('removeFromStyleMask', {
      'styleMask': styleMask.name,
    });
  }
}
