// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class EsenDoIconButton extends StatelessWidget {
  const EsenDoIconButton(
      {Key? key,
      required this.borderColor,
      required this.borderRadius,
      required this.borderWidth,
      required this.buttonSize,
      required this.fillColor,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final Widget icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius) : null,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
          child: IconButton(
            icon: icon,
            onPressed: onPressed,
            splashRadius: buttonSize,
          ),
        ),
      );
}
