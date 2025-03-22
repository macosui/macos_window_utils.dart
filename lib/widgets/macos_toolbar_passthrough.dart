/// A collection of widgets that intercept and handle native macOS toolbar
/// events (e.g.: double-click to maximize, dragging to move window) so they can
/// be processed within a Flutter app.
///
/// The issue: interacting (double-clicking or dragging) with the area within
/// a flutter app where the native macOS toolbar would typically be triggers
/// native actions like maximizing or moving the window. This is the expected
/// behavior on "empty" areas, but undesirable when interacting with an input,
/// such as a button.
///
/// This solution involves creating and managing invisible native macOS UI
/// elements (Mainly NSViews) in Swift that intercept these events, preventing
/// them from being processed natively and instead passing them to the Flutter
/// engine for further handling.
library;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:macos_window_utils/window_manipulator.dart';

const _debounceDuration = Duration(milliseconds: 10);

/// An optional "scope" for toolbar items.
///
/// When a scoped item detects a change that would normally trigger a
/// reevaluation of their position and size, they instead notify their parent
/// scope, which then notifies all their scoped items to reevaluate and update
/// their positions and sizes.
///
/// Since Flutter is optimized to avoid unnecessarily drawing UI elements,
/// detecting some changes in UI can be expensive or cumbersome. Even worse,
/// sometimes the implementation may not be able to detect these changes at all
/// (such as in some scrolling widgets or widgets that either move or change
/// size in uncommon ways), resulting in flutter widgets being out of sync
/// relative to their native counterpart.
///
/// Wrapping multiple [MacosToolbarPassthrough] under a
/// [MacosToolbarPassthroughScope] allows you to both:
/// 1- Trigger a reevaluation on all scoped items when any of them internally
/// requests a reevaluation.
/// 2- Manually trigger these reevaluation events if needed (see:
/// [notifyChangesOf]).
class MacosToolbarPassthroughScope extends StatefulWidget {
  const MacosToolbarPassthroughScope({super.key, required this.child});

  final Widget child;

  static void Function() notifyChangesOf(BuildContext context) {
    final result = maybeNotifyChangesOf(context);
    assert(result != null, 'No MacosToolbarPassthroughScope found in context');
    return result!;
  }

  static void Function()? maybeNotifyChangesOf(BuildContext context) {
    return _DescendantRegistry.maybeOf(context)?.notifyChanges;
  }

  @override
  State<MacosToolbarPassthroughScope> createState() =>
      _MacosToolbarPassthroughScopeState();
}

class _MacosToolbarPassthroughScopeState
    extends State<MacosToolbarPassthroughScope> {
  late final _DescendantRegistry _registry;

  @override
  void initState() {
    super.initState();
    _registry = _DescendantRegistry(_onReevaluationRequested);
  }

  @override
  void dispose() {
    _registry.dispose();
    super.dispose();
  }

  void _onReevaluationRequested() {
    for (final descendant in _registry.all.values) {
      descendant.requestUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedDescendantRegistry(
      registry: _registry,
      child: widget.child,
    );
  }
}

class _DescendantRegistry {
  _DescendantRegistry(void Function() onReevaluationRequested)
      : _onReevaluationRequested = onReevaluationRequested;

  final void Function() _onReevaluationRequested;
  Timer? _debounceTimer;

  final Map<String, MacosToolbarPassthroughState> _descendantsById = {};

  void register(final MacosToolbarPassthroughState descendant) {
    _descendantsById.putIfAbsent(descendant._key.toString(), () => descendant);
  }

  void unregister(final String descendantKey) {
    _descendantsById.remove(descendantKey);
  }

  UnmodifiableMapView<String, MacosToolbarPassthroughState> get all =>
      UnmodifiableMapView(_descendantsById);

  void notifyChanges() {
    // Debounce change notifications
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      _debounceDuration,
      _onReevaluationRequested,
    );
  }

  void dispose() {
    _debounceTimer?.cancel();
  }

  static _DescendantRegistry? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedDescendantRegistry>()
        ?.registry;
  }
}

class _InheritedDescendantRegistry extends InheritedWidget {
  const _InheritedDescendantRegistry({
    required super.child,
    required this.registry,
  });

  final _DescendantRegistry registry;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

/// A widget that intercepts and handles native macOS toolbar events (e.g.:
/// double-click to maximize, dragging to move window), forwarding them so they
/// can be processed within Flutter only.
///
/// Most simple UI (e.g.: static size and fixed positions) may only need to use
/// one or multiple [MacosToolbarPassthrough]. More complex use cases may also
/// require the addition of a [MacosToolbarPassthroughScope].
///
/// You can manually trigger the reevaluation of a [MacosToolbarPassthrough] by
/// calling [MacosToolbarPassthroughState.requestUpdate] method from its state,
/// which you may access by using a [GlobalKey] as its `key`.
class MacosToolbarPassthrough extends StatefulWidget {
  const MacosToolbarPassthrough({
    super.key,
    required this.child,
    this.enableDebugLayers = false,
  });

  final Widget child;
  final bool enableDebugLayers;

  @override
  State<MacosToolbarPassthrough> createState() =>
      MacosToolbarPassthroughState();
}

class MacosToolbarPassthroughState extends State<MacosToolbarPassthrough>
    with WidgetsBindingObserver {
  /// A unique key identifying the content to be measured.
  final GlobalKey _key = GlobalKey();

  bool _isDisposed = false;
  _DescendantRegistry? _registry;
  Timer? _debounceTimer;
  ScrollableState? _scrollable;
  Offset? _lastPosition;
  Size? _lastSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Register this instance if scoped
    _registry = _DescendantRegistry.maybeOf(context);
    _registry?.register(this);
    _scrollable = Scrollable.maybeOf(context);
  }

  @override
  void dispose() {
    _sendRemoveMessage();
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _registry?.unregister(_key.toString());
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeMetrics() => _onChange();

  void _onChange() {
    // If under a parent scope
    if (_registry case _DescendantRegistry registry) {
      // Notify scope of changes
      registry.notifyChanges();
    }
    // If standalone item
    else {
      // Debounce updates to native UI counterpart
      _debounceTimer?.cancel();
      _debounceTimer = Timer(
        _debounceDuration,
        () {
          requestUpdate();
        },
      );
    }
  }

  void requestUpdate() {
    // Immediately update position and size
    _sendUpdateMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Wait for next frame to update position and size
      _sendUpdateMessage();
    });
  }

  void _sendUpdateMessage() async {
    if (_isDisposed ||
        !mounted ||
        !context.mounted ||
        _key.currentContext?.mounted != true) {
      return;
    }

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null || !renderBox.attached) {
      return;
    }

    Offset? position = renderBox.localToGlobal(Offset.zero);
    Size? size = renderBox.size;

    // If item is child of a scrollable
    if (_scrollable?.position case ScrollPosition scrollPosition) {
      // With the viewport related to the scroll area
      if (RenderAbstractViewport.maybeOf(renderBox) case final viewport?) {
        final double viewportExtent;
        final double sizeExtent;
        switch (scrollPosition.axis) {
          case Axis.horizontal:
            viewportExtent = viewport.paintBounds.width;
            sizeExtent = size.width;
            break;

          case Axis.vertical:
            viewportExtent = viewport.paintBounds.height;
            sizeExtent = size.height;
            break;
        }

        final RevealedOffset viewportOffset = viewport
            .getOffsetToReveal(renderBox, 0.0, axis: scrollPosition.axis);

        // Get viewport deltas
        final double deltaStart = viewportOffset.offset - scrollPosition.pixels;
        final double deltaEnd = deltaStart + sizeExtent;

        // Check if item is within viewport
        final bool isWithinViewport =
            (deltaStart >= 0.0 && deltaStart < viewportExtent) ||
                (deltaEnd > 0.0 && deltaEnd < viewportExtent);

        // If this item is within the scrollable viewport
        if (isWithinViewport) {
          final double startClipped = deltaStart < 0.0 ? -deltaStart : 0.0;
          final double endClipped =
              deltaEnd > viewportExtent ? deltaEnd - viewportExtent : 0.0;

          // Clip overextending content
          switch (scrollPosition.axis) {
            case Axis.horizontal:
              // Clip content is overextending horizontally
              position = position.translate(startClipped, 0.0);
              size = Size(size.width - startClipped - endClipped, size.height);
              break;

            case Axis.vertical:
              // Clip content is overextending vertically
              position = position.translate(0.0, startClipped);
              size = Size(size.width, size.height - startClipped - endClipped);
              break;
          }
        }
        // If this item is not within the scrollable viewport
        else {
          position = null;
          size = null;
        }
      }
    }

    // Update native view if was removed or changed position or size
    if (_lastPosition != position || _lastSize != size) {
      // If item is not within the scrollable viewport
      if (position == null || size == null) {
        _sendRemoveMessage();
      }
      // Update item position and size
      else {
        await WindowManipulator.updateToolbarPassthroughView(
          id: _key.toString(),
          x: position.dx,
          y: position.dy,
          width: size.width,
          height: size.height,
          enableDebugLayers: widget.enableDebugLayers,
        );
      }
      _lastPosition = position;
      _lastSize = size;
    }
  }

  void _sendRemoveMessage() async {
    await WindowManipulator.removeToolbarPassthroughView(id: _key.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Triggers evaluation on layout changed event
        _onChange();
        return SizedBox(
          key: _key,
          child: widget.child,
        );
      },
    );
  }
}
