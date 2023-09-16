import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    Key? key,
    this.style,
    this.maxLines,
    this.textAlign,
    this.containsHtml = false,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  final bool containsHtml;

  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
