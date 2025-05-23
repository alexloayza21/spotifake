import 'package:flutter/material.dart';

void snackBar(BuildContext context, {Widget? content, Duration? duration, Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: content ?? const Text(''),
    duration: duration ?? const Duration(seconds: 2),
    backgroundColor: backgroundColor,
  ));
}