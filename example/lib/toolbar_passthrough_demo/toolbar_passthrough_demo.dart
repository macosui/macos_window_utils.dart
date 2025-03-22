import 'package:appkit_ui_element_colors/appkit_ui_element_colors.dart';
import 'package:example/generic_widgets/button.dart';
import 'package:example/global_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gradient_borders/gradient_borders.dart';

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

This demo allows you to enable the so-called “Tab Example” which demonstrates
the usage of the `MacosToolbarPassthrough` widget. The Tab Example is
implemented in the `tab_example.dart` file in the `lib/toolbar_passthrough_demo`
directory. Make note of how the example listens to the `ScrollController` and
calls `MacosToolbarPassthroughScope.maybeNotifyChangesOf(context);` when the
scroll position changes to make sure the passthrough views are updated.

After the Tab Example has been enabled, you will see a number of tabs appear in
the toolbar. The tabs can be clicked and dragged without affecting the native
toolbar. Double clicking or dragging the area outside of any tabs will trigger
native window behavior.
''';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MarkdownBody(data: markdownDescription),
                ),
                const Divider(),
                StreamBuilder<Object>(
                  stream: GlobalState.instance.stream,
                  builder: (context, snapshot) {
                    if (GlobalState.instance.isTabExampleEnabled) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MacosWindowUtilsButton(
                          child: const Text('Disable Tab Example'),
                          onPressed: () {
                            GlobalState.instance.isTabExampleEnabled = false;
                          },
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MacosWindowUtilsButton(
                              child: const Text(
                                  'Enable Tab Example (with debug layers)'),
                              onPressed: () {
                                GlobalState.instance.isTabExampleEnabled = true;
                                GlobalState.instance
                                        .enableDebugLayersForToolbarPassthroughViews =
                                    true;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MacosWindowUtilsButton(
                              child: const Text(
                                  'Enable Tab Example (without debug layers)'),
                              onPressed: () {
                                GlobalState.instance.isTabExampleEnabled = true;
                                GlobalState.instance
                                        .enableDebugLayersForToolbarPassthroughViews =
                                    false;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: '**Warning:** The debug layers are meant to stay '
                        'either enabled or disabled during the entire '
                        'lifecycle of the app. Disabling them during runtime '
                        'will result in unexpected behavior. It is recommended '
                        'to restart the app before toggling the debug layers.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
