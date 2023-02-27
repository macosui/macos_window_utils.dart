import 'package:macos_window_utils/macos/ns_app_presentation_option.dart';
import 'package:macos_window_utils/window_manipulator/window_manipulator.dart';

export 'package:macos_window_utils/macos/ns_app_presentation_option.dart';

/// TODO: document this
class NSAppPresentationOptions {
  final Set<NSAppPresentationOption> options;

  const NSAppPresentationOptions._fromSet(this.options);

  static NSAppPresentationOptions empty =
      NSAppPresentationOptions._fromSet(const {});

  factory NSAppPresentationOptions.from(
      Iterable<NSAppPresentationOption> iterable) {
    return NSAppPresentationOptions._fromSet(Set.from(iterable));
  }

  NSAppPresentationOptions insert(NSAppPresentationOption option) {
    final newSet = {...options, option};
    return NSAppPresentationOptions.from(newSet);
  }

  NSAppPresentationOptions remove(NSAppPresentationOption option) {
    final newSet = options.where((element) => element != option);
    return NSAppPresentationOptions.from(newSet);
  }

  bool contains(NSAppPresentationOption option) {
    return options.contains(option);
  }

  bool containsAll(Iterable<NSAppPresentationOption> options) {
    return this.options.containsAll(options);
  }

  void assertRestrictions() {
    assert(
        !options.contains(NSAppPresentationOption.autoHideDock) ||
            !options.contains(NSAppPresentationOption.hideDock),
        'autoHideDock and hideDock are mutually exclusive: You may specify one '
        'or the other, but not both.');

    assert(
        !options.contains(NSAppPresentationOption.autoHideMenuBar) ||
            !options.contains(NSAppPresentationOption.hideMenuBar),
        'autoHideMenuBar and hideMenuBar are mutually exclusive: You may '
        'specify one or the other, but not both.');

    assert(
        !options.contains(NSAppPresentationOption.hideMenuBar) ||
            options.contains(NSAppPresentationOption.hideDock),
        'If you specify hideMenuBar, it must be accompanied by hideDock.');

    assert(
        !options.contains(NSAppPresentationOption.autoHideMenuBar) ||
            (options.contains(NSAppPresentationOption.hideDock) ||
                options.contains(NSAppPresentationOption.autoHideDock)),
        'If you specify autoHideMenuBar, it must be accompanied by either '
        'hideDock or autoHideDock.');

    assert(
        (!options.contains(NSAppPresentationOption.disableProcessSwitching) &&
                !options.contains(NSAppPresentationOption.disableForceQuit) &&
                !options.contains(
                    NSAppPresentationOption.disableSessionTermination) &&
                !options.contains(
                    NSAppPresentationOption.disableMenuBarTransparency)) ||
            (options.contains(NSAppPresentationOption.hideDock) ||
                options.contains(NSAppPresentationOption.autoHideDock)),
        'If you specify any of disableProcessSwitching, disableForceQuit, '
        'disableSessionTermination, or disableMenuBarTransparency, it must be '
        'accompanied by either hideDock or autoHideDock.');

    assert(
        !options.contains(NSAppPresentationOption.autoHideToolbar) ||
            (options.contains(NSAppPresentationOption.fullScreen) &&
                options.contains(NSAppPresentationOption.autoHideMenuBar)),
        'autoHideToolbar may be used only when both fullScreen and '
        'autoHideMenuBar are also set.');
  }

  void apply() {
    assertRestrictions();

    WindowManipulator.removeFullScreenPresentationOptions();
    for (final option in options) {
      WindowManipulator.addFullScreenPresentationOption(option);
    }
  }
}
