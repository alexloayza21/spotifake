import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget {
  const BasicAppBar({super.key, required this.colorText});
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: colorText.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20, 
                color: colorText
              ),
            )
          ),
        ),
      );
  }
}