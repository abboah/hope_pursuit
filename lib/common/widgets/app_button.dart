import 'package:flutter/material.dart';

class AppButton {
  static Widget button(
      {double? height,
      double? width,
      Color? color,
      String? text,
      TextStyle? style,
      Function()? onTap}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: color),
      child: TextButton(
        onPressed: onTap!,
        child: Text(text!, style: style),
      ),
    );
  }
}
