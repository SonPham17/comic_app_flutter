import 'package:animations/animations.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_page.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/open_container_wrapper.dart';
import 'package:flutter/material.dart';

class ItemGridComic extends StatelessWidget {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final Comic comic;

  ItemGridComic({@required this.comic});

  @override
  Widget build(BuildContext context) {
    return OpenContainerWrapper(
      transitionType: _transitionType,
      child: DetailComicPage(
        comic: comic,
      ),
      closedBuilder: (BuildContext context, VoidCallback openContainer){
        return Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: openContainer,
                child: Image.network(
                    'https://www.nae.vn/ttv/ttv/public/images/story/${comic.image}.jpg',
                    height: 180,
                    fit: BoxFit.cover),
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
      },
    );
  }
}
