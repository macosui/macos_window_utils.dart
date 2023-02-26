import 'dart:async';
import 'dart:collection';

import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event.dart';

/// TODO: document this
class NSWindowDelegateEventHandler {
  final _events = <NSWindowDelegateEvent>[];
  final _onChangedStreamController =
      StreamController<List<NSWindowDelegateEvent>>.broadcast();

  List<NSWindowDelegateEvent> get events => UnmodifiableListView(_events);

  Stream<List<NSWindowDelegateEvent>> get onChangedStream =>
      _onChangedStreamController.stream;

  void addEvent(NSWindowDelegateEvent event) {
    if (_events.isEmpty) {
      _events.add(event);
      _onChangedStreamController.add(events);
      return;
    }

    final lastEvent = _events.last;
    if (lastEvent.name == event.name) {
      _events.removeLast();
      final newLastEvent = lastEvent.withIncrementedNumberOfOccurrences();
      _events.add(newLastEvent);
      _onChangedStreamController.add(events);
      return;
    }

    _events.add(event);
    _onChangedStreamController.add(events);
  }
}
