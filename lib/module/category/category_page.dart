import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thể loại',style: TvStyle.fontApp()),
      ),
      body: Container(
        child: Text('Thể loại page'),
      ),
    );
  }
}
