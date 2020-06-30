import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';

class ItemGridComic extends StatelessWidget {
  final Comic comic;

  ItemGridComic({@required this.comic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail/comic_page',
                  arguments: comic);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  'https://www.nae.vn/ttv/ttv/public/images/story/${comic.image}.jpg',
                  height: 180,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            child: Center(
                child: Text(
                  comic.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TvStyle.fontAppWithSize(12),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}
