import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ToolbarPassthroughDemo extends StatefulWidget {
  const ToolbarPassthroughDemo({super.key});

  @override
  State<ToolbarPassthroughDemo> createState() => _ToolbarPassthroughDemoState();
}

class _ToolbarPassthroughDemoState extends State<ToolbarPassthroughDemo> {
  bool _enableDebugLayers = true;

  @override
  Widget build(BuildContext context) {
    const markdownDescription = '''
Interacting (double-clicking or dragging) with areas in a Flutter app where
the native macOS toolbar would typically be triggers native actions like
maximizing or moving the window. While this is expected behavior on “empty”
areas, it’s undesirable when interacting with interactive widgets, such as
buttons and draggable interfaces.

macos_window_utils provides a way to pass through toolbar interactions to the
Flutter app, allowing you to define areas where double-clicks and drag gestures
should be ignored by the native window.
''';

    return const Markdown(data: markdownDescription);
  }
}
