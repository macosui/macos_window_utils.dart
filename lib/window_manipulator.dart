import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:macos_window_utils/macos/macos_blur_view_state.dart';
import 'package:macos_window_utils/macos/macos_toolbar_style.dart';
import 'package:macos_window_utils/macos/visual_effect_view_properties.dart';
import 'package:macos_window_utils/window_effect.dart';

/// Class that provides methods to manipulate the application's window.
class WindowManipulator {
  static final MethodChannel _kChannel =
      const MethodChannel('com.adrian_samoticha/macos_window_utils');
  static final Completer<void> _kCompleter = Completer<void>();

  /// Initializes the [WindowManipulator] class.
  ///
  /// _Example_
  /// ```dart
  /// Future<void> main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await WindowManipulator.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initialize() async {
    await _kChannel.invokeMethod('Initialize');
    _kCompleter.complete();
  }

  /// Sets specified effect for the window.
  ///
  /// Examples:
  ///
  /// ```dart
  /// await Window.setEffect(
  ///   effect: WindowEffect.windowBackground,
  /// );
  /// ```
  ///
  /// ```dart
  /// await Window.setEffect(
  ///   effect: WindowEffect.sidebar,
  /// );
  /// ```
  static Future<void> setEffect({required WindowEffect effect}) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(
      'setEffect',
      {'effect': effect.index},
    );
  }

  /// Gets the height of the titlebar.
  ///
  /// This value is used to determine the [[TitlebarSafeArea]] widget.
  /// If the full-size content view is enabled, this value will be the height of
  /// the titlebar. If the full-size content view is disabled, this value will
  /// be 0.
  static Future<double> getTitlebarHeight() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod('GetTitlebarHeight');
  }

  /// Sets the document to be edited.
  ///
  /// This will change the appearance of the close button on the titlebar.
  static Future<void> setDocumentEdited() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetDocumentEdited');
  }

  /// Sets the document to be unedited.
  static Future<void> setDocumentUnedited() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetDocumentUnedited');
  }

  /// Sets the represented file of the window.
  static Future<void> setRepresentedFilename(String filename) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetRepresentedFile', {
      'filename': filename,
    });
  }

  /// Sets the represented URL of the window.
  static Future<void> setRepresentedUrl(String url) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetRepresentedURL', {
      'url': url,
    });
  }

  /// Hides the titlebar of the window.
  static Future<void> hideTitle() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('HideTitle');
  }

  /// Shows the titlebar of the window.
  static Future<void> showTitle() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('ShowTitle');
  }

  /// Makes the window's titlebar transparent.
  static Future<void> makeTitlebarTransparent() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('MakeTitlebarTransparent');
  }

  /// Makes the window's titlebar opaque.
  static Future<void> makeTitlebarOpaque() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('MakeTitlebarOpaque');
  }

  /// Enables the window's full-size content view.
  ///
  /// This expands the area that Flutter can draw to to fill the entire window.
  /// It is recommended to enable the full-size content view when making
  /// the titlebar transparent.
  static Future<void> enableFullSizeContentView() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('EnableFullSizeContentView');
  }

  /// Disables the window's full-size content view.
  static Future<void> disableFullSizeContentView() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('DisableFullSizeContentView');
  }

  /// Zooms the window.
  static Future<void> zoomWindow() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('ZoomWindow');
  }

  /// Unzooms the window.
  static Future<void> unzoomWindow() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('UnzoomWindow');
  }

  /// Returns if the window is zoomed.
  static Future<bool> isWindowZoomed() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod('IsWindowZoomed');
  }

  /// Returns if the window is fullscreened.
  static Future<bool> isWindowFullscreened() async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod('IsWindowFullscreened');
  }

  /// Hides the window's zoom button.
  static Future<void> hideZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('HideZoomButton');
  }

  /// Shows the window's zoom button.
  ///
  /// The zoom button is visible by default.
  static Future<void> showZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('ShowZoomButton');
  }

  /// Hides the window's miniaturize button.
  static Future<void> hideMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('HideMiniaturizeButton');
  }

  /// Shows the window's miniaturize button.
  ///
  /// The miniaturize button is visible by default.
  static Future<void> showMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('ShowMiniaturizeButton');
  }

  /// Hides the window's close button.
  static Future<void> hideCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('HideCloseButton');
  }

  /// Shows the window's close button.
  ///
  /// The close button is visible by default.
  static Future<void> showCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('ShowCloseButton');
  }

  /// Enables the window's zoom button.
  ///
  /// The zoom button is enabled by default.
  static Future<void> enableZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('EnableZoomButton');
  }

  /// Disables the window's zoom button.
  static Future<void> disableZoomButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('DisableZoomButton');
  }

  /// Enables the window's miniaturize button.
  ///
  /// The miniaturize button is enabled by default.
  static Future<void> enableMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('EnableMiniaturizeButton');
  }

  /// Disables the window's miniaturize button.
  static Future<void> disableMiniaturizeButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('DisableMiniaturizeButton');
  }

  /// Enables the window's close button.
  ///
  /// The close button is enabled by default.
  static Future<void> enableCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('EnableCloseButton');
  }

  /// Disables the window's close button.
  static Future<void> disableCloseButton() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('DisableCloseButton');
  }

  /// Gets whether the window is currently being resized by the user.
  static Future<bool> isWindowInLiveResize() async {
    if (!Platform.isMacOS) {
      throw UnsupportedError(
          'isWindowInLiveResize() is only available on macOS.');
    }

    await _kCompleter.future;
    return await _kChannel.invokeMethod('IsWindowInLiveResize');
  }

  /// Sets the window's alpha value.
  static Future<void> setWindowAlphaValue(double value) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetWindowAlphaValue', <String, dynamic>{
      'value': value,
    });
  }

  /// Gets if the window is visible.
  static Future<bool> isWindowVisible() async {
    if (!Platform.isMacOS) {
      throw UnsupportedError('isWindowVisible() is only available on macOS.');
    }

    await _kCompleter.future;
    return await _kChannel.invokeMethod('IsWindowVisible');
  }

  /// Sets the window background color to the default (opaque) window color.
  ///
  /// This method mainly affects the window's titlebar.
  static Future<void> setWindowBackgroundColorToDefaultColor() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetWindowBackgroundColorToDefaultColor');
  }

  /// Sets the window background color to clear.
  static Future<void> setWindowBackgroundColorToClear() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetWindowBackgroundColorToClear');
  }

  /// Sets the blur view state.
  static Future<void> setBlurViewState(MacOSBlurViewState state) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetBlurViewState', <String, dynamic>{
      'state': state.toString().split('.').last,
    });
  }

  /// Adds a visual effect subview to the application's window and returns its
  /// ID.
  static Future<int> addVisualEffectSubview(
      VisualEffectSubviewProperties properties) async {
    await _kCompleter.future;
    return await _kChannel.invokeMethod(
        'AddVisualEffectSubview', properties.toMap());
  }

  /// Updates the properties of a visual effect subview.
  static Future<void> updateVisualEffectSubviewProperties(
      int visualEffectSubviewId,
      VisualEffectSubviewProperties properties) async {
    await _kCompleter.future;
    await _kChannel
        .invokeMethod('UpdateVisualEffectSubviewProperties', <String, dynamic>{
      'visualEffectSubviewId': visualEffectSubviewId,
      ...properties.toMap(),
    });
  }

  /// Removes a visual effect subview from the application's window.
  static Future<void> removeVisualEffectSubview(
      int visualEffectSubviewId) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('RemoveVisualEffectSubview', <String, dynamic>{
      'visualEffectSubviewId': visualEffectSubviewId,
    });
  }

  /// Overrides the brightness setting of the window.
  static Future<void> overrideMacOSBrightness({
    required bool dark,
  }) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod(
      'OverrideMacOSBrightness',
      {
        'dark': dark,
      },
    );
  }

  /// Adds a toolbar to the window.
  static Future<void> addToolbar() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('AddToolbar');
  }

  /// Removes the window's toolbar.
  static Future<void> removeToolbar() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('RemoveToolbar');
  }

  /// Sets the window's toolbar style.
  ///
  /// For this method to have an effect, the window needs to have had a toolbar
  /// added with the `addToolbar` method beforehand.
  ///
  /// Usage example:
  /// ```dart
  /// Window.addToolbar();
  /// Window.setToolbarStyle(MacOSToolbarStyle.unified);
  /// ```
  static Future<void> setToolbarStyle(
      {required MacOSToolbarStyle toolbarStyle}) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetToolbarStyle', {
      'toolbarStyle': toolbarStyle.name,
    });
  }

  /// Enables the window's shadow.
  static Future<void> enableShadow() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('EnableShadow');
  }

  /// Disables the window's shadow.
  static Future<void> disableShadow() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('DisableShadow');
  }

  /// Invalidates the window's shadow.
  ///
  /// This is a fairly technical method and is included here for
  /// completeness' sake. Normally, it should not be necessary to use it.
  static Future<void> invalidateShadows() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('InvalidateShadows');
  }

  /// Adds an empty mask image to the window's view.
  ///
  /// This will effectively disable the `NSVisualEffectView`'s effect.
  ///
  /// **Warning:** It is recommended to disable the window's shadow using
  /// `Window.disableShadow()` when using this method. Keeping the shadow
  /// enabled when using an empty mask image can cause visual artifacts
  /// and performance issues.
  static Future<void> addEmptyMaskImage() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('AddEmptyMaskImage');
  }

  /// Removes the window's mask image.
  static Future<void> removeMaskImage() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('RemoveMaskImage');
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
  /// `Window.makeWindowFullyTransparent()`.
  static Future<void> ignoreMouseEvents() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('IgnoreMouseEvents');
  }

  /// Makes the window acknowledge mouse events.
  ///
  /// This method can be used to make parts of the window click-through, which
  /// may be desirable when used in conjunction with
  /// `Window.makeWindowFullyTransparent()`.
  static Future<void> acknowledgeMouseEvents() async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('AcknowledgeMouseEvents');
  }

  /// Sets the subtitle of the window.
  ///
  /// To remove the subtitle, pass an empty string to this method.
  static Future<void> setSubtitle(String subtitle) async {
    await _kCompleter.future;
    await _kChannel.invokeMethod('SetSubtitle', {
      'subtitle': subtitle,
    });
  }
}
