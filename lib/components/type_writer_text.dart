import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  final Duration typingDuration;
  final Duration deletingDuration;

  final Duration initialDelay;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.typingDuration = const Duration(milliseconds: 50),
    this.deletingDuration = const Duration(milliseconds: 30),
    this.initialDelay = Duration.zero,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  late String _displayedText;
  late String _incomingText;
  late String _outgoingText;

  @override
  void initState() {
    super.initState();
    _incomingText = widget.text;
    _outgoingText = '';
    _displayedText = '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(widget.initialDelay, animateText);
    });
  }

  void animateText() async {
    final backwardLength = _outgoingText.length;
    if (backwardLength > 0) {
      for (var i = backwardLength; i >= 0; i--) {
        await Future.delayed(widget.deletingDuration);
        setState(() {
          _displayedText = _outgoingText.substring(0, i);
        });
      }
    }
    final forwardLength = _incomingText.length;
    if (forwardLength > 0) {
      for (var i = 0; i <= forwardLength; i++) {
        await Future.delayed(widget.typingDuration);
        setState(() {
          _displayedText = _incomingText.substring(0, i);
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _outgoingText = oldWidget.text;
      _incomingText = widget.text;
      Future.delayed(widget.initialDelay, animateText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.style,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
    );
  }
}