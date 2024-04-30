import 'package:flutter/material.dart';

textStyle(
        {Color? textColor,
        double? size,
        FontWeight? weight,
        TextOverflow? overflow,
        TextDecoration? decoration,
        String? fontFamily,
        FontStyle? fontStyle}) =>
    TextStyle(
        color: textColor,
        fontSize: size,
        fontWeight: weight,
        overflow: overflow,
        decoration: decoration,
        fontFamily: fontFamily,
        fontStyle: fontStyle);

//final TextStyle cardTextStyle = TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold);
