import 'package:example/main_area/main_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_window_utils/window_manipulator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManipulator.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'macos_window_utils demo',
      theme: CupertinoThemeData(
        barBackgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
        scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('macos_window_utils demo'),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: const SafeArea(
          child: MainArea(),
        ),
      ),
    );
  }
}
