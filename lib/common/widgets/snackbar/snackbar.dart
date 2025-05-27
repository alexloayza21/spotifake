import 'package:flutter/material.dart';

void snackBar(BuildContext context, {String? content, Duration? duration, Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content ?? '', style: TextStyle(color: Colors.white),),
    duration: duration ?? const Duration(seconds: 2),
    backgroundColor: backgroundColor,
  ));
}