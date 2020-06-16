import 'package:comicappflutter/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isCenterTitle;

  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;
  final List<Widget> actions;

  PageContainer({
    this.title,
    this.child,
    this.bloc,
    this.di,
    this.actions,
    this.isCenterTitle,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
        ...bloc,
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: isCenterTitle,
          title: Text(
            title,
            style: TextStyle(color: AppColor.green),
          ),
          actions: actions,
        ),
        body: child,
      ),
    );
  }
}
