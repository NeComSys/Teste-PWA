import 'package:flutter/material.dart';

globalSnackBar(
  String message,
  IconData iconData,
  Color iconColor,
  Color fontColor,
  Color backgroundColor,
) {
  // return ScaffoldMessenger.of(context).showSnackBar(
  return SnackBar(
    content: Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 25,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            message.toString(),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: fontColor,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );
  // );
}
