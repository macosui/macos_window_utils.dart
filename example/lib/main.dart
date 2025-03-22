import 'package:appkit_ui_element_colors/appkit_ui_element_colors.dart';
import 'package:example/global_state.dart';
import 'package:example/main_area/main_area.dart';
import 'package:example/sidebar_content.dart';
import 'package:example/toolbar_passthrough_demo/tab_example.dart';
import 'package:example/util/transparent_sidebar_and_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_window_utils/macos_window_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManipulator.initialize(enableWindowDelegate: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness? _brightness;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        _brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
      });
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'macos_window_utils demo',
      theme: CupertinoThemeData(
        barBackgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 0.0),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontSize: 14,
            color: _brightness == Brightness.dark
                ? const Color.fromRGBO(255, 255, 255, 1.0)
                : const Color.fromRGBO(0, 0, 0, 1.0),
          ),
        ),
      ),
      home: const DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1.0),
          backgroundBlendMode: BlendMode.clear,
        ),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: GlobalState.instance.stream,
        builder: (context, snapshot) {
          return TransparentSidebarAndContent(
            isOpen: _isSidebarOpen,
            width: 280.0,
            sidebarBuilder: () => const TitlebarSafeArea(
              child: SidebarContent(),
            ),
            child: TitlebarSafeArea(
              isEnabled: !GlobalState.instance.isTabExampleEnabled,
              child: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: GlobalState.instance.isTabExampleEnabled
                      ? const Padding(
                          padding: EdgeInsets.only(left: 52.0),
                          child: TabExample(),
                        )
                      : const Text('macos_window_utils demo'),
                  leading: GlobalState.instance.isTabExampleEnabled
                      ? const SizedBox()
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: UiElementColorBuilder(
                              uiElementColorContainerInstanceProvider:
                                  OwnedUiElementColorContainerInstanceProvider(),
                              builder: (context, colorContainer) {
                                return Icon(
                                  CupertinoIcons.sidebar_left,
                                  color: colorContainer.controlAccentColor,
                                );
                              }),
                          onPressed: () => setState(
                            () => _isSidebarOpen = !_isSidebarOpen,
                          ),
                        ),
                ),
                child: DefaultTextStyle(
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                  child: SafeArea(
                    child: MainArea(
                      setState: setState,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
