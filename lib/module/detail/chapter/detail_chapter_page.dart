import 'dart:io';
import 'package:epub_kitty/epub_kitty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class DetailChapterPage extends StatefulWidget {
  @override
  _DetailChapterPageState createState() => _DetailChapterPageState();
}

class _DetailChapterPageState extends State<DetailChapterPage> {
  static const pageChannel = EventChannel('com.xiaofwang.epub_kitty/page');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () async {
              Directory appDocDir = await getApplicationDocumentsDirectory();
              print('$appDocDir');

//              String iosBookPath = '${appDocDir.path}/4.epub';
//              String androidBookPath =
//                  'file:///android_asset/PhysicsSyllabus.epub';
//              EpubKitty.setConfig("iosBook", "#32a852", "vertical", true);
//              EpubKitty.open(iosBookPath);
            },
            child: Container(
              child: Text('open epub'),
            ),
          ),
        ),
      ),
    );
  }
}
