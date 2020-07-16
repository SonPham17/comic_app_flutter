import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/db/model/chapter.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_bloc.dart';
import 'package:comicappflutter/module/detail/comic/history_comic_event.dart';
import 'package:comicappflutter/module/detail/comic/like_comic_event.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/show_more_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class DetailComicPage extends StatefulWidget {
  final Comic comic;
  final bool isOpenDownload;

  DetailComicPage({this.comic, this.isOpenDownload});

  @override
  _DetailComicPageState createState() => _DetailComicPageState();
}

class _DetailComicPageState extends State<DetailComicPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: DetailService(),
        ),
        ProxyProvider<DetailService, DetailRepo>(
          update: (context, detailService, previous) =>
              DetailRepo(detailService: detailService),
        ),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.green,
          mini: true,
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Icon(Icons.arrow_upward),
        ),
        appBar: AppBar(
          title: Text(
            widget.comic.name,
            style: TvStyle.fontApp(),
          ),
        ),
        body: DetailComicListWidget(
          comic: widget.comic,
          isOpenDownload: widget.isOpenDownload,
          scrollController: _scrollController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}

class DetailComicListWidget extends StatefulWidget {
  final Comic comic;
  final bool isOpenDownload;
  final ScrollController scrollController;

  DetailComicListWidget(
      {this.comic, this.isOpenDownload, this.scrollController});

  @override
  _DetailComicListWidgetState createState() => _DetailComicListWidgetState();
}

class _DetailComicListWidgetState extends State<DetailComicListWidget> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DetailComicBloc(
        detailRepo: Provider.of(context),
      ),
      child: Consumer<DetailComicBloc>(
        builder: (context, bloc, child) => SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: <Widget>[
              DetailHeaderComicWidget(
                comic: widget.comic,
              ),
              DetailIntroComicWidget(
                comic: widget.comic,
                bloc: bloc,
              ),
              DetailFooterComicWidget(
                bloc: bloc,
                comic: widget.comic,
                isOpenDownload: widget.isOpenDownload,
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

class _DetailIntroComicWidgetState extends State<DetailIntroComicWidget>
    with SingleTickerProviderStateMixin {
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
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            alignment: Alignment.topCenter,
            child: ShowMoreText(
              widget.comic.introduce,
              showMoreText: 'Xem thêm',
              showLessText: 'Thu gọn',
              showMoreStyle: TvStyle.fontAppWithCustom(color: AppColor.green),
              style: TvStyle.fontAppWithCustom(),
              shouldShowLessText: true,
            ),
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
  final bool isOpenDownload;

  const DetailFooterComicWidget({this.comic, this.bloc, this.isOpenDownload});

  @override
  _DetailFooterComicWidgetState createState() =>
      _DetailFooterComicWidgetState();
}

class _DetailFooterComicWidgetState extends State<DetailFooterComicWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    if (widget.isOpenDownload) {
      widget.bloc.getChaptersListInDB(widget.comic.id);
    } else {
      widget.bloc.getChaptersList(widget.comic.id);
    }
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
          widget.isOpenDownload
              ? StreamProvider<List<ChapterComic>>.value(
                  value: widget.bloc.chaptersInDBStream,
                  child: Consumer<List<ChapterComic>>(
                    builder: (context, data, child) {
                      if (data == null) {
                        return Container(
                          height: 170,
                          child: Center(
                            child: Text('Chưa có dữ liệu về truyện này',
                                style: TvStyle.fontAppWithCustom()),
                          ),
                        );
                      }

                      var listChapter = Chapter.parseChaptersListFromDB(data);
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: ListTile.divideTiles(
                            color: Colors.black38,
                            tiles: listChapter.map((chapter) => InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/detail/chapter_db_page',
                                        arguments: {
                                          'content':
                                              data[listChapter.indexOf(chapter)]
                                                  .content,
                                          'name_id_chapter':
                                              data[listChapter.indexOf(chapter)]
                                                  .nameIdChapter,
                                          'content_title_of_chapter':
                                              data[listChapter.indexOf(chapter)]
                                                  .contentTitleOfChapter,
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Phần ${chapter.vol} - ${chapter.nameIdChapter}: ${chapter.contentTitleOfChapter}',
                                      style:
                                          TvStyle.fontAppWithCustom(size: 16),
                                    ),
                                  ),
                                ))).toList(),
                      );
                    },
                  ),
                )
              : Container(
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

                          if (data.length == 1) {
                            return ListView.builder(
                              itemBuilder: (context, index) => Container(
                                child: InkWell(
                                  onTap: () {
                                    widget.bloc.event.add(
                                        HistoryComicEvent(comic: widget.comic));
                                    Navigator.pushNamed(
                                        context, '/detail/chapter_page',
                                        arguments: {
                                          'id': data[0][index].id,
                                          'comic': widget.comic,
                                          'chapter': data[0][index],
                                        });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${data[0][index].nameIdChapter}: ${data[0][index].contentTitleOfChapter}',
                                        style:
                                            TvStyle.fontAppWithCustom(size: 16),
                                      ),
                                      Text(
                                        '${data[0][index].updatedAt}',
                                        style:
                                            TvStyle.fontAppWithCustom(size: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    width: 1.0,
                                    color: Colors.black12,
                                  )),
                                ),
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data[0].length,
                            );
                          } else {
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
                                            child: InkWell(
                                              onTap: () {
                                                widget.bloc.event.add(
                                                    HistoryComicEvent(
                                                        comic: widget.comic));
                                                Navigator.pushNamed(context,
                                                    '/detail/chapter_page',
                                                    arguments: {
                                                      'id': chapter.id,
                                                      'comic': widget.comic,
                                                      'chapter': chapter,
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
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                width: 1.0,
                                                color: Colors.black12,
                                              )),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            width: double.infinity,
                                          ),
                                        )
                                        .toList(),
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(AppColor.green),
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
