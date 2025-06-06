import 'dart:ui';

import 'package:example/global_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:macos_window_utils/widgets/macos_toolbar_passthrough.dart';

class TabExample extends StatefulWidget {
  const TabExample({super.key});

  @override
  State<TabExample> createState() => _TabExampleState();
}

class _TabExampleState extends State<TabExample> {
  // In order to update the passthrough views when the scroll position changes,
  // we need to define a scroll controller and listen to it.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WindowManipulator.addToolbar();
    WindowManipulator.enableFullSizeContentView();
    WindowManipulator.makeTitlebarTransparent();
    WindowManipulator.hideTitle();

    // When the scroll position changes, we need to notify the passthrough views
    // to update their position.
    _scrollController.addListener(() {
      setState(() {
        MacosToolbarPassthroughScope.maybeNotifyChangesOf(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: MacosToolbarPassthroughScope(
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (i) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: MacosToolbarPassthrough(
                  enableDebugLayers: GlobalState
                      .instance.enableDebugLayersForToolbarPassthroughViews,
                  child: _Draggable(
                    child: _Tab(index: i),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _Draggable extends StatefulWidget {
  final Widget child;

  const _Draggable({required this.child});

  @override
  State<_Draggable> createState() => _DraggableState();
}

class _DraggableState extends State<_Draggable> {
  double _xOffset = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      dragStartBehavior: DragStartBehavior.down,
      supportedDevices: const {PointerDeviceKind.mouse},
      onHorizontalDragUpdate: (details) => setState(() {
        _xOffset += details.primaryDelta!;
      }),
      onHorizontalDragEnd: (details) => setState(() {
        _xOffset = 0;
      }),
      onHorizontalDragCancel: () => setState(() {
        _xOffset = 0;
      }),
      child: TweenAnimationBuilder(
        duration:
            _xOffset == 0 ? const Duration(milliseconds: 300) : Duration.zero,
        curve: Curves.ease,
        tween: Tween<double>(begin: _xOffset, end: _xOffset),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(value, 0.0),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDark = brightness == Brightness.dark;

    return Container(
      width: 128,
      height: 32,
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromRGBO(90, 90, 90, 1.0)
            : const Color.fromRGBO(220, 220, 220, 1.0),
        borderRadius: BorderRadius.circular(4),
        boxShadow: isDark
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color.fromRGBO(25, 25, 25, 0.4),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Tab ${index + 1}',
            style: TextStyle(
              color: isDark
                  ? const Color.fromRGBO(255, 255, 255, 0.67)
                  : const Color.fromRGBO(0, 0, 0, 0.5),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
