import 'dart:async';

import 'package:macos_window_utils/macos/macos_toolbar_style.dart';
import 'package:macos_window_utils/macos/ns_visual_effect_view_material.dart';
import 'package:macos_window_utils/macos/ns_visual_effect_view_state.dart';
import 'package:macos_window_utils/window_manipulator.dart';

import 'command_list/command.dart';

class CommandListProvider {
  static List<Command> getCommands() {
    return [
      ...List.generate(NSVisualEffectViewMaterial.values.length, (int index) {
        final currentMaterial = NSVisualEffectViewMaterial.values[index];
        return Command(
          name: 'setMaterial(${currentMaterial.toString()})',
          description:
              'Changes the window\'s subview\'s material property to `${currentMaterial.name}`.',
          function: () => WindowManipulator.setMaterial(currentMaterial),
        );
      }),
      Command(
        name: 'enterFullscreen()',
        function: () => WindowManipulator.enterFullscreen(),
      ),
      Command(
        name: 'exitFullscreen()',
        function: () => WindowManipulator.exitFullscreen(),
      ),
      Command(
        name: 'setDocumentEdited()',
        description: 'Sets the document to be edited.\n\n'
            'This changes the appearance of the close button on the '
            'titlebar:\n\n'
            '![image](https://user-images.githubusercontent.com/86920182/209436903-0a6c1f5a-4ab6-454f-a37d-78a5d699f3df.png)',
        function: () => WindowManipulator.setDocumentEdited(),
      ),
      Command(
        name: 'setDocumentUnedited()',
        function: () => WindowManipulator.setDocumentUnedited(),
      ),
      Command(
        name: 'setRepresentedFilename(\'some file.txt\')',
        function: () =>
            WindowManipulator.setRepresentedFilename('some file.txt'),
      ),
      Command(
        name: 'setRepresentedFilename(\'\')',
        function: () => WindowManipulator.setRepresentedFilename(''),
      ),
      Command(
        name: 'setRepresentedUrl(\'http://some_url.com/\')',
        function: () =>
            WindowManipulator.setRepresentedUrl('http://some_url.com/'),
      ),
      Command(
        name: 'setRepresentedUrl(\'\')',
        function: () => WindowManipulator.setRepresentedUrl(''),
      ),
      Command(
        name: 'hideTitle()',
        function: () => WindowManipulator.hideTitle(),
      ),
      Command(
        name: 'showTitle()',
        function: () => WindowManipulator.showTitle(),
      ),
      Command(
        name: 'makeTitlebarTransparent()',
        function: () => WindowManipulator.makeTitlebarTransparent(),
      ),
      Command(
        name: 'makeTitlebarOpaque()',
        function: () => WindowManipulator.makeTitlebarOpaque(),
      ),
      Command(
        name: 'enableFullSizeContentView()',
        description: 'Enables the window\'s full-size content view.\n\n'
            'This expands the area that Flutter can draw to to fill the entire'
            ' window. It is recommended to enable the full-size content view '
            'when making the titlebar transparent.',
        function: () => WindowManipulator.enableFullSizeContentView(),
      ),
      Command(
        name: 'disableFullSizeContentView()',
        function: () => WindowManipulator.disableFullSizeContentView(),
      ),
      Command(
        name: 'zoomWindow()',
        function: () => WindowManipulator.zoomWindow(),
      ),
      Command(
        name: 'unzoomWindow()',
        function: () => WindowManipulator.unzoomWindow(),
      ),
      Command(
        name: 'hideZoomButton()',
        function: () => WindowManipulator.hideZoomButton(),
      ),
      Command(
        name: 'showZoomButton()',
        function: () => WindowManipulator.showZoomButton(),
      ),
      Command(
        name: 'hideMiniaturizeButton()',
        function: () => WindowManipulator.hideMiniaturizeButton(),
      ),
      Command(
        name: 'showMiniaturizeButton()',
        function: () => WindowManipulator.showMiniaturizeButton(),
      ),
      Command(
        name: 'hideCloseButton()',
        function: () => WindowManipulator.hideCloseButton(),
      ),
      Command(
        name: 'showCloseButton()',
        function: () => WindowManipulator.showCloseButton(),
      ),
      Command(
        name: 'enableZoomButton()',
        function: () => WindowManipulator.enableZoomButton(),
      ),
      Command(
        name: 'disableZoomButton()',
        function: () => WindowManipulator.disableZoomButton(),
      ),
      Command(
        name: 'enableMiniaturizeButton()',
        function: () => WindowManipulator.enableMiniaturizeButton(),
      ),
      Command(
        name: 'disableMiniaturizeButton()',
        function: () => WindowManipulator.disableMiniaturizeButton(),
      ),
      Command(
        name: 'enableCloseButton()',
        function: () => WindowManipulator.enableCloseButton(),
      ),
      Command(
        name: 'disableCloseButton()',
        function: () => WindowManipulator.disableCloseButton(),
      ),
      ...List.generate(4, (int index) {
        final alphaValue = 0.25 + (index * 0.25);
        return Command(
          name: 'setWindowAlphaValue($alphaValue)',
          function: () => WindowManipulator.setWindowAlphaValue(alphaValue),
        );
      }),
      Command(
        name: 'setWindowBackgroundColorToDefaultColor()',
        function: () =>
            WindowManipulator.setWindowBackgroundColorToDefaultColor(),
      ),
      Command(
        name: 'setWindowBackgroundColorToClear()',
        function: () => WindowManipulator.setWindowBackgroundColorToClear(),
      ),
      Command(
        name: 'setNSVisualEffectViewState(NSVisualEffectViewState.active)',
        description: 'Sets the NSVisualEffectView\'s state to `active`.\n\n'
            '**Description:** The backdrop should always appear active.',
        function: () => WindowManipulator.setNSVisualEffectViewState(
            NSVisualEffectViewState.active),
      ),
      Command(
        name: 'setNSVisualEffectViewState(NSVisualEffectViewState.inactive)',
        description: 'Sets the NSVisualEffectView\'s state to `inactive`.\n\n'
            '**Description:** The backdrop should always appear inactive.',
        function: () => WindowManipulator.setNSVisualEffectViewState(
            NSVisualEffectViewState.inactive),
      ),
      Command(
        name: 'setNSVisualEffectViewState('
            'NSVisualEffectViewState.followsWindowActiveState)',
        description: 'Sets the NSVisualEffectView\'s state to '
            '`followsWindowActiveState`.\n\n'
            '**Description:** The backdrop should automatically appear active '
            'when the window is active, and inactive when it is not.',
        function: () => WindowManipulator.setNSVisualEffectViewState(
            NSVisualEffectViewState.followsWindowActiveState),
      ),
      Command(
        name: 'overrideMacOSBrightness(dark: false)',
        function: () => WindowManipulator.overrideMacOSBrightness(dark: false),
      ),
      Command(
        name: 'overrideMacOSBrightness(dark: true)',
        function: () => WindowManipulator.overrideMacOSBrightness(dark: true),
      ),
      Command(
        name: 'addToolbar()',
        function: () => WindowManipulator.addToolbar(),
      ),
      Command(
        name: 'removeToolbar()',
        function: () => WindowManipulator.removeToolbar(),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: MacOSToolbarStyle.automatic)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the system determines '
            'the toolbar’s appearance and location.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: MacOSToolbarStyle.automatic),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: MacOSToolbarStyle.expanded)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'below the window title.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: MacOSToolbarStyle.expanded),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: MacOSToolbarStyle.preference)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'below the window title with toolbar items centered in the toolbar.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: MacOSToolbarStyle.preference),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: MacOSToolbarStyle.unified)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'next to the window title.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: MacOSToolbarStyle.unified),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: MacOSToolbarStyle.unifiedCompact)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'next to the window title and with reduced margins to allow more '
            'focus on the window’s contents.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: MacOSToolbarStyle.unifiedCompact),
      ),
      Command(
        name: 'enableShadow()',
        function: () => WindowManipulator.enableShadow(),
      ),
      Command(
        name: 'disableShadow()',
        function: () => WindowManipulator.disableShadow(),
      ),
      Command(
        name: 'invalidateShadows()',
        description: 'Invalidates the window\'s shadow.\n\n'
            'This is a fairly technical method and is included here for '
            'completeness\' sake. Normally, it should not be necessary to use '
            'it.',
        function: () => WindowManipulator.invalidateShadows(),
      ),
      Command(
        name: 'addEmptyMaskImage()',
        description: 'Adds an empty mask image to the window\'s view.\n\n'
            'This will effectively disable the `NSVisualEffectView`\'s effect.'
            '\n\n'
            '**Warning:** It is recommended to disable the window\'s shadow '
            'using `WindowManipulator.disableShadow()` when using this method. '
            'Keeping the shadow enabled when using an empty mask image can '
            'cause visual artifacts and performance issues.',
        function: () => WindowManipulator.addEmptyMaskImage(),
      ),
      Command(
        name: 'removeMaskImage()',
        function: () => WindowManipulator.removeMaskImage(),
      ),
      Command(
        name: 'makeWindowFullyTransparent()',
        description: 'Makes a window fully transparent (with no blur effect).'
            '\n\n'
            'This is a convenience method which executes:\n\n'
            '`\nsetWindowBackgroundColorToClear();\n'
            'makeTitlebarTransparent();\naddEmptyMaskImage();\n'
            'disableShadow();\n`'
            // Using fenced code blocks causes an exception to be thrown whose
            // message reads “The Scrollbar's ScrollController has no
            // ScrollPosition attached. [...]”. For this reason, normal codes
            // are using here.
            '\n\n**Warning:** When the window is fully transparent, its '
            'highlight effect (the thin white line at the top of the window) '
            'is still visible. This is considered a bug and may change in a '
            'future version.',
        function: () => WindowManipulator.makeWindowFullyTransparent(),
      ),
      Command(
        name: 'ignoreMouseEvents()',
        description: 'Makes the window ignore mouse events.\n\n'
            'This method can be used to make parts of the window '
            'click-through, which may be desirable when used in conjunction '
            'with `makeWindowFullyTransparent()`.\n\n'
            '**Note:** This example project will automatically re-acknowledge '
            'mouse events five seconds after this method has been called.',
        function: () {
          WindowManipulator.ignoreMouseEvents();
          Timer(const Duration(seconds: 5),
              () => WindowManipulator.acknowledgeMouseEvents());
        },
      ),
      Command(
        name: 'acknowledgeMouseEvents()',
        function: () => WindowManipulator.acknowledgeMouseEvents(),
      ),
      Command(
        name: 'setSubtitle(\'foobar\')',
        function: () => WindowManipulator.setSubtitle('foobar'),
      ),
      Command(
        name: 'setSubtitle(\'\')',
        description: 'Passing an empty string to `setSubtitle` removes the '
            'subtitle.',
        function: () => WindowManipulator.setSubtitle(''),
      ),
    ];
  }
}
