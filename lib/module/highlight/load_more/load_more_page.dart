import 'package:comicappflutter/base/base_widget.dart';
import 'package:flutter/material.dart';

class LoadMorePage extends StatefulWidget {
  @override
  _LoadMorePageState createState() => _LoadMorePageState();
}

class _LoadMorePageState extends State<LoadMorePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var result= ModalRoute.of(context).settings.arguments as Map;
    print(result['title']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: Container(),
    );
  }
}

