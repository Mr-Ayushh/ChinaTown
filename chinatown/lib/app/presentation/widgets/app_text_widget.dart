import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final bool? softWrap;
  final String label;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final Color? selectionColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  const AppText(
      {super.key,
      required this.label,
      this.maxLines,
      this.textOverflow,
      this.selectionColor,
      this.softWrap,
      this.textStyle,
      this.textAlign});

  @override
  Widget build(BuildContext context) => Text(
        label,
        overflow: textOverflow,
        maxLines: maxLines,
        selectionColor: selectionColor,
        softWrap: softWrap,
        style: textStyle,
        textAlign: textAlign,
      );
}
