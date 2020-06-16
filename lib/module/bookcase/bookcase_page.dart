import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';

class BookcasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tủ sách',style: TvStyle.fontApp()),
      ),
      body: Container(
        child: Text('Tủ sách page'),
      ),
    );
  }
}
