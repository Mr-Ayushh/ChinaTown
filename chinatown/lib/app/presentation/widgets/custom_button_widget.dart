import 'package:flutter/material.dart';

import 'app_text_widget.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.width,
      this.height,
      this.bgColor,
      this.labelColor,
      required this.label,
      this.onTap,
      this.onHover});
  final double? width, height;
  final Color? bgColor, labelColor;
  final String label;
  final VoidCallback? onTap, onHover;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        //onHover: onHover,
        child: Container(
          width: width ?? 73.0,
          height: height ?? 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: bgColor,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12.0),
          child: AppText(
            label: label,
            softWrap: true,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              color: labelColor,
              fontSize: 14.0,
            ),
          ),
        ),
      );
}
