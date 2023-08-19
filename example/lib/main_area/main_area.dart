import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_demo.dart';
import 'package:example/main_area/window_manipulator_demo/window_manipulator_demo.dart';
import 'package:flutter/cupertino.dart';

class MainArea extends StatefulWidget {
  const MainArea({super.key, required this.setState});

  final void Function(void Function()) setState;

  @override
  State<MainArea> createState() => _MainAreaState();
}

class _MainAreaState extends State<MainArea> {
  int? currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        _SegmentedControl(
          currentTabIndex: currentTabIndex,
          onTabIndexChanged: (newIndex) => setState(() {
            currentTabIndex = newIndex;
          }),
        ),
        Expanded(
          child: IndexedStack(
            index: currentTabIndex,
            children: [
              WindowManipulatorDemo(
                setState: widget.setState,
              ),
              const NSWindowDelegateDemo(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.currentTabIndex,
    required this.onTabIndexChanged,
  });

  final int? currentTabIndex;
  final void Function(int?) onTabIndexChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      groupValue: currentTabIndex,
      onValueChanged: onTabIndexChanged,
      children: const {
        0: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'WindowManipulator demo',
          ),
        ),
        1: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'NSWindowDelegate demo',
          ),
        ),
      },
    );
  }
}
