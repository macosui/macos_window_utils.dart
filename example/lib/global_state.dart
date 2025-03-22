import 'dart:async';

class GlobalState {
  static final GlobalState instance = GlobalState();

  final StreamController<GlobalState> _streamController =
      StreamController<GlobalState>.broadcast();

  Stream<GlobalState> get stream => _streamController.stream;

  bool _isTabExampleEnabled = false;

  /// Whether the tab example is enabled and displayed in the toolbar.
  bool get isTabExampleEnabled => _isTabExampleEnabled;

  set isTabExampleEnabled(bool value) {
    _isTabExampleEnabled = value;
    _streamController.add(this);
  }

  bool _enableDebugLayersForToolbarPassthroughViews = false;

  /// Whether to enable debug layers for the toolbar passthrough views.
  bool get enableDebugLayersForToolbarPassthroughViews =>
      _enableDebugLayersForToolbarPassthroughViews;

  set enableDebugLayersForToolbarPassthroughViews(bool value) {
    _enableDebugLayersForToolbarPassthroughViews = value;
    _streamController.add(this);
  }
}
