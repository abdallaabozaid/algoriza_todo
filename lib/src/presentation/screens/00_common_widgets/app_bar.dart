import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    Key? key,
    required this.titleText,
    this.actions,
    this.tabBarWidget,
    this.leadingIcon,
    required this.borderSideWidth,
  }) : super(key: key);
  final String titleText;
  final List<Widget>? actions;
  final Widget? tabBarWidget;
  final Widget? leadingIcon;
  final double borderSideWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          width: borderSideWidth,
          color: Colors.black45,
        ),
      ),
      automaticallyImplyLeading: false,
      leading: leadingIcon,
      leadingWidth: 40,
      title: Text(
        titleText,
      ),
      actions: actions,
      bottom: tabBarWidget == null
          ? null
          : PreferredSize(
              child: tabBarWidget!,
              preferredSize: Size(
                double.infinity,
                70.h,
              ),
            ),
    );
  }
}
