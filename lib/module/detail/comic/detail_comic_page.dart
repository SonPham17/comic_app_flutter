import 'package:animations/animations.dart';
import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/module/detail/chapter/detail_chapter_page.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_bloc.dart';
import 'package:comicappflutter/module/detail/comic/like_comic_event.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/open_container_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class DetailComicPage extends StatelessWidget {
  final Comic comic;

  DetailComicPage({this.comic});

  @override
  Widget build(BuildContext context) {
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
      create: (_) => DetailComicBloc(
        detailRepo: Provider.of(context),
      ),
      child: Consumer<DetailComicBloc>(
        builder: (context, bloc, child) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DetailHeaderComicWidget(
                comic: comic,
              ),
              DetailIntroComicWidget(
                comic: comic,
                bloc: bloc,
              ),
              DetailFooterComicWidget(
                bloc: bloc,
                comic: comic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailIntroComicWidget extends StatefulWidget {
  final Comic comic;
  final DetailComicBloc bloc;

  DetailIntroComicWidget({this.comic, this.bloc});

  @override
  _DetailIntroComicWidgetState createState() => _DetailIntroComicWidgetState();
}

class _DetailIntroComicWidgetState extends State<DetailIntroComicWidget> {
  @override
  void initState() {
    super.initState();
    widget.bloc.checkComicIsLiked(widget.comic.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                LineAwesomeIcons.book,
                color: AppColor.green,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Giới thiệu',
                style: TvStyle.fontAppWithCustom(
                    size: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.green),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  widget.bloc.isLiked
                      ? widget.bloc.likeSink.add(false)
                      : widget.bloc.likeSink.add(true);
                  widget.bloc.event.add(LikeComicEvent(comic: widget.comic));
                },
                child: StreamProvider<bool>.value(
                    initialData: false,
                    value: widget.bloc.likeStream,
                    child: Consumer<bool>(
                      builder: (context, isLiked, child) => isLiked
                          ? Icon(
                              LineAwesomeIcons.heart,
                              color: AppColor.green,
                            )
                          : Icon(
                              LineAwesomeIcons.heart_o,
                              color: AppColor.green,
                            ),
                    )),
              ),
            ],
          ),
          Text(
            widget.comic.introduce,
            style: TvStyle.fontAppWithCustom(),
          ),
        ],
      ),
    );
  }
}

class DetailHeaderComicWidget extends StatelessWidget {
  final Comic comic;

  const DetailHeaderComicWidget({Key key, this.comic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(comic.timeFix * 1000);
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
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tác giả: ${comic.author}',
                  style: TvStyle.fontAppWithCustom(),
                ),
                Text(
                  'Đánh giá: ${comic.avgRate}/5',
                  style: TvStyle.fontAppWithCustom(),
                ),
                Text(
                  'Trạng thái: ${comic.finish == 1 ? 'Đã hoàn thành' : 'Chưa hoàn thành'}',
                  style: TvStyle.fontAppWithCustom(),
                ),
                Text(
                  'Cập nhật mới nhất: ${date.hour.toString().length == 1 ? '0${date.hour}' : date.hour}:'
                  '${date.minute.toString().length == 1 ? '0${date.minute}' : date.minute} '
                  '${date.day}/${date.month}/${date.year}',
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

class DetailFooterComicWidget extends StatefulWidget {
  final Comic comic;
  final DetailComicBloc bloc;

  const DetailFooterComicWidget({this.comic, this.bloc});

  @override
  _DetailFooterComicWidgetState createState() =>
      _DetailFooterComicWidgetState();
}

class _DetailFooterComicWidgetState extends State<DetailFooterComicWidget> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    widget.bloc.getChaptersList(widget.comic.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            height: 1,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.format_list_bulleted,
                  color: AppColor.green,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Danh sách chương',
                  style: TvStyle.fontAppWithCustom(
                    color: AppColor.green,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          Container(
            child: StreamProvider<List<List<Chapter>>>.value(
              value: widget.bloc.chaptersStream,
              child: Consumer<List<List<Chapter>>>(
                builder: (context, data, child) {
                  if (data != null) {
                    if (data.length == 0) {
                      return Container(
                        height: 170,
                        child: Center(
                          child: Text('Chưa có dữ liệu về truyện này',
                              style: TvStyle.fontAppWithCustom()),
                        ),
                      );
                    }

                    if (data.length != 0) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ExpansionTile(
                          title: Text(
                            'Phần ${index + 1}',
                            style: TvStyle.fontAppWithCustom(size: 18),
                          ),
                          children: <Widget>[
                            Column(
                              children: data[index]
                                  .map(
                                    (chapter) => Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    '/detail/chapter_page',
                                                    arguments: {
                                                      'id': chapter.id,
                                                    });
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '${chapter.nameIdChapter}: ${chapter.contentTitleOfChapter}',
                                                    style: TvStyle
                                                        .fontAppWithCustom(
                                                            size: 16),
                                                  ),
                                                  Text(
                                                    '${chapter.updatedAt}',
                                                    style: TvStyle
                                                        .fontAppWithCustom(
                                                            size: 11),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            child: Icon(LineAwesomeIcons
                                                .cloud_download),
                                            onTap: () {
                                              print(chapter
                                                  .contentTitleOfChapter);
                                            },
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                          width: 1.0,
                                          color: Colors.black12,
                                        )),
                                      ),
                                      padding: EdgeInsets.all(8),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        itemCount: data.length,
                      );
                    }
                  }

                  return Container(
                    height: 170,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColor.green,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }
}
