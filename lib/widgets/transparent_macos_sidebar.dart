import 'package:flutter/material.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:macos_window_utils/widgets/visual_effect_subview_container/visual_effect_subview_container.dart';
import 'package:macos_window_utils/widgets/visual_effect_subview_container/visual_effect_subview_container_resize_event_relay.dart';

class TransparentMacOSSidebar extends StatelessWidget {
  final Widget child;
  final double alphaValue;
  final NSVisualEffectViewMaterial material;
  final NSVisualEffectViewState state;
  final VisualEffectSubviewContainerResizeEventRelay? resizeEventRelay;

  /// A widget that applies a visual effect subview to a child widget that
  /// represents the application's sidebar.
  ///
  /// The [alphaValue] is applied to the visual effect subview. It does not
  /// affect the opacity of the [child].
  ///
  /// By default, a [TransparentMacOSSidebar] updates its visual effect view
  /// whenever its `build` method runs. If manual control over its update
  /// behavior is desired, it can be supplied a
  /// [VisualEffectSubviewContainerResizeEventRelay] through which its update
  /// behavior can be controlled manually.
  ///
  /// Usage example:
  /// ```dart
  /// TransparentMacOSSidebar(
  ///   child: Container(
  ///     width: 250.0,
  ///   ),
  /// )
  /// ```
  const TransparentMacOSSidebar(
      {super.key,
      this.alphaValue = 1.0,
      this.material = NSVisualEffectViewMaterial.sidebar,
      this.state = NSVisualEffectViewState.followsWindowActiveState,
      this.resizeEventRelay,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return VisualEffectSubviewContainer(
      alphaValue: alphaValue,
      material: material,
      resizeEventRelay: resizeEventRelay,
      state: state,
      // Due to the fact that visual effect subviews cannot be updated while the
      // window is being resized, doing so can cause visual artifacts. To hide
      // those artifacts, the TransparentMacOSSidebar widget adds a large
      // negative top margin to the visual effect subview.
      padding: EdgeInsets.only(top: -4320.0),
      child: child,
    );
  }
}
