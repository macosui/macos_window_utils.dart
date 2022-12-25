import 'package:flutter/cupertino.dart';

import 'command.dart';
import 'command_list_entry.dart';
export 'command.dart';

class CommandList extends StatelessWidget {
  const CommandList(
      {super.key,
      required this.commands,
      required this.searchTerm,
      required this.selectedIndex,
      required this.setIndex});

  final List<Command> commands;
  final String searchTerm;
  final int selectedIndex;
  final void Function(int) setIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: commands
            .where((Command command) => command.name.contains(searchTerm))
            .toList()
            .asMap()
            .map((int index, Command command) {
              final widget = CommandListEntry(
                index: index,
                selectedIndex: selectedIndex,
                command: command,
                select: () => setIndex(index),
              );

              return MapEntry(index, widget);
            })
            .values
            .toList(),
      ),
    );
  }
}
