import 'package:example/main_area/command_list/description_box.dart';
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

  List<Command> get _filteredCommands => commands
      .where((Command command) => command.name.contains(searchTerm))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildScrollView()),
        _buildDescriptionBox(),
      ],
    );
  }

  Widget _buildDescriptionBox() => SizedBox(
        width: 233.0,
        child: DescriptionBox(
          text: _filteredCommands[selectedIndex].description,
        ),
      );

  Widget _buildScrollView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _filteredCommands
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
