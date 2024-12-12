import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final double height;
  final Color color;
  final Color textColor;
  final Color hintColor;
  final double borderRadius;
  final bool isPasswordField;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.height,
    this.keyboardType = TextInputType.text,
    this.color = white,
    this.textColor = primaryDarkColor,
    this.hintColor = gray,
    this.borderRadius = 8.0,
    this.isPasswordField = false,
    this.controller,
    this.onChanged,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = widget.isPasswordField
        ? const EdgeInsets.symmetric(horizontal: 16)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 0);

    return Container(
      width: double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: _focusNode.hasFocus ? primaryLightColor : lightGray,
          width: 1.0,
        ),
      ),
      alignment: Alignment.center,
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        cursorColor: primaryLightColor,
        obscureText: widget.isPasswordField ? _obscureText : false,
        style: TextStyle(color: widget.textColor),
        onChanged: widget.onChanged,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: widget.hintColor),
          border: InputBorder.none,
          isDense: true,
          contentPadding: contentPadding,
          suffixIcon: widget.isPasswordField
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: widget.hintColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : const SizedBox(width: 0, height: 0),
        ),
      ),
    );
  }
}