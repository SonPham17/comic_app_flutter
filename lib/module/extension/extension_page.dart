import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';

class ExtensionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mở rộng', style: TvStyle.fontApp()),
      ),
      body: Container(
        child: Text('Mở rộng page'),
      ),
    );
  }
}
