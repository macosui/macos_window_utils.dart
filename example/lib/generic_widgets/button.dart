import 'package:appkit_ui_element_colors/appkit_ui_element_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class MacosWindowUtilsButton extends StatefulWidget {
  const MacosWindowUtilsButton(
      {super.key, this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<MacosWindowUtilsButton> createState() => _MacosWindowUtilsButtonState();
}

class _MacosWindowUtilsButtonState extends State<MacosWindowUtilsButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapUp: (_) => setState(() => _isPressed = false),
      child: UiElementColorBuilder(
          uiElementColorContainerInstanceProvider:
              OwnedUiElementColorContainerInstanceProvider(),
          builder: (context, colorContainer) {
            return Opacity(
              opacity: _isPressed ? 0.9 : 1.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorContainer.controlAccentColor,
                      Color.fromRGBO(
                        (colorContainer.controlAccentColor.r * 200).floor(),
                        (colorContainer.controlAccentColor.g * 200).floor(),
                        (colorContainer.controlAccentColor.b * 200).floor(),
                        1.0,
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  border: const GradientBoxBorder(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.5),
                        Color.fromRGBO(255, 255, 255, 0.0),
                        Color.fromRGBO(255, 255, 255, 0.0),
                        Color.fromRGBO(255, 255, 255, 0.0),
                      ],
                    ),
                    width: 1.7,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white),
                  child: widget.child,
                ),
              ),
            );
          }),
    );
  }
}
