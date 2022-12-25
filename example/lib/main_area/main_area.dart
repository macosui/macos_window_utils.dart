import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'command_list/command_list.dart';
import 'command_list_provider.dart';

class MainArea extends StatefulWidget {
  const MainArea({
    Key? key,
  }) : super(key: key);

  @override
  State<MainArea> createState() => _MainAreaState();
}

class _MainAreaState extends State<MainArea> {
  final FocusNode _focusNode = FocusNode();
  String _searchTerm = '';
  int _selectedIndex = 0;

  void _setSelectedIndex(int newIndex) {
    _selectedIndex =
        newIndex.clamp(0, CommandListProvider.getCommands().length - 1);
  }

  void _addToSelectedIndex(int value) {
    _setSelectedIndex(_selectedIndex + value);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (value) {
        if (value is KeyDownEvent || value is KeyRepeatEvent) {
          if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
            setState(() {
              _addToSelectedIndex(1);
            });
          }

          if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
            setState(() {
              _addToSelectedIndex(-1);
            });
          }
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              onChanged: (value) => setState(() {
                _selectedIndex = 0;
                _searchTerm = value;
              }),
            ),
          ),
          Expanded(
            child: CommandList(
              searchTerm: _searchTerm,
              selectedIndex: _selectedIndex,
              commands: CommandListProvider.getCommands(),
              setIndex: (int newIndex) => setState(() {
                _setSelectedIndex(newIndex);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
