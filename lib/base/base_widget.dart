import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
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
  final Widget leading;

  PageContainer({
    this.title,
    this.child,
    this.bloc,
    this.di,
    this.actions,
    this.isCenterTitle,
    this.leading,
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
          leading: leading,
          centerTitle: isCenterTitle,
          title: Text(
            title,
            style: TvStyle.fontApp(),
          ),
          actions: actions,
        ),
        body: child,
      ),
    );
  }
}
