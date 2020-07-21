import 'package:animations/animations.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_page.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/open_container_wrapper.dart';
import 'package:flutter/material.dart';

class ItemGridComic extends StatelessWidget {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final Comic comic;
  final bool isOpenDownload;
  final Function(bool) funcClose;

  ItemGridComic({@required this.comic, this.funcClose, this.isOpenDownload});

  @override
  Widget build(BuildContext context) {
    return OpenContainerWrapper(
      transitionType: _transitionType,
      child: DetailComicPage(
        comic: comic,
        isOpenDownload: isOpenDownload,
      ),
      onClosed: funcClose,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: openContainer,
                child: FadeInImage.assetNetwork(
                  height: 160,
                  placeholder: 'assets/images/main_icon.png',
                  image:
                      'https://www.nae.vn/ttv/ttv/public/images/story/${comic.image}.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
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
      },
    );
  }
}
