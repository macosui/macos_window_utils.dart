import 'package:macos_window_utils/macos/ns_visual_effect_view_material.dart';
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
    ];
  }
}
