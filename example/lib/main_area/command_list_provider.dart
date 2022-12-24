import 'command_list/command.dart';

class CommandListProvider {
  static List<Command> getCommands() {
    return List.generate(128, (index) {
      // TODO: return real commands
      return Command(
        name: 'foo $index',
        function: () {},
      );
    });
  }
}
