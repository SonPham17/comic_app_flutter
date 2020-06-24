import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_bloc.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailComicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Comic comic = ModalRoute.of(context).settings.arguments;
    return PageContainer(
      title: comic.name,
      bloc: [],
      di: [
        Provider.value(
          value: DetailService(),
        ),
        ProxyProvider<DetailService, DetailRepo>(
          update: (context, detailService, previous) =>
              DetailRepo(detailService: detailService),
        ),
      ],
      child: DetailComicListWidget(
        comic: comic,
      ),
    );
  }
}

class DetailComicListWidget extends StatelessWidget {
  final Comic comic;

  DetailComicListWidget({this.comic});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DetailComicBloc.getInstance(
        detailRepo: Provider.of(context),
      ),
      child: Consumer<DetailComicBloc>(
        builder: (context, bloc, child) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DetailHeaderComicWidget(
                comic: comic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailHeaderComicWidget extends StatelessWidget {
  final Comic comic;

  const DetailHeaderComicWidget({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              'https://www.nae.vn/ttv/ttv/public/images/story/${comic.image}.jpg',
              width: 140,
              fit: BoxFit.cover,
              height: 190,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tác giả: ${comic.author}',
                  style: TvStyle.fontAppWithCustom(),
                ),
                Text(
                  'Đánh giá: ${comic.avgRate}',
                  style: TvStyle.fontAppWithCustom(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
