import 'package:flutter/material.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key, this.title, this.hideBackButton = false, this.actions, this.backgroundColor});
  final Widget? title;
  final bool? hideBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {

    Color colorText = IsDarkMode(context).isDarkMode ? Colors.white : Colors.black;
    
    return AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        title: title ?? Text(''),
        centerTitle: true,
        actions: actions ?? [],
        leading: hideBackButton! ? Container() : IconButton(
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
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}