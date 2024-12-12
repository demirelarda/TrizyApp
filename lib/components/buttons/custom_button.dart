import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color? color;
  final List<Color>? gradientColors;
  final VoidCallback onClick;
  final double height;
  final double? width;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onClick,
    this.color,
    this.gradientColors,
    this.height = 50,
    this.width,
    this.isLoading = false,
  })  : assert(gradientColors == null || color == null,
  'Only one color type should be specified!');

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onClick();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double opacity = _isPressed && !widget.isLoading ? 0.8 : 1.0;

    return GestureDetector(
      onTapDown: widget.isLoading ? null : _onTapDown,
      onTapUp: widget.isLoading ? null : _onTapUp,
      onTapCancel: widget.isLoading ? null : _onTapCancel,
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: widget.height,
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: widget.gradientColors != null
                ? LinearGradient(
              colors: widget.gradientColors!,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: widget.gradientColors == null ? widget.color : null,
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3.0,
            ),
          )
              : Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}