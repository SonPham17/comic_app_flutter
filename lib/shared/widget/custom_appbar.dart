import 'package:comicappflutter/shared/app_color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize{
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height=kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      color: AppColor.green,
      child: child,
    );
  }
}