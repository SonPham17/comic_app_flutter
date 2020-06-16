import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';

class HighlightPage extends StatefulWidget {
  @override
  _HighlightPageState createState() => _HighlightPageState();
}

class _HighlightPageState extends State<HighlightPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nổi bật', style: TvStyle.fontApp()),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(_count.toString()),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              color: Colors.red,
              child: SizedBox(
                width: 32,
                height: 32,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tăng',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
