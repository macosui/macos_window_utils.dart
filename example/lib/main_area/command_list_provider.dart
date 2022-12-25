import 'package:macos_window_utils/macos/ns_visual_effect_view_material.dart';
import 'package:macos_window_utils/window_manipulator.dart';

import 'command_list/command.dart';

class CommandListProvider {
  static List<Command> getCommands() {
    return [
      ...List.generate(NSVisualEffectViewMaterial.values.length, (int index) {
        final currentMaterial = NSVisualEffectViewMaterial.values[index];
        return Command(
          name: 'setMaterial(material: ${currentMaterial.toString()})',
          description:
              'Changes the window\'s subview\'s material property to `${currentMaterial.name}`.',
          function: () =>
              WindowManipulator.setMaterial(material: currentMaterial),
        );
      }),
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
    ];
  }
}
