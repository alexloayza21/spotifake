import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';

class ModeButton extends StatelessWidget {
  const ModeButton({
    super.key, required this.title, required this.child, this.onTap,
  });

  final String title;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 20,
        children: [
          
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Color(0xff30393C).withValues(alpha: 0.5),
                shape: BoxShape.circle
              ),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: child,
                ),
              ),
            ),
          ),    

          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center
          ),
          
        ],
      ),
    );
  }
}