import 'dart:convert';
import 'dart:io';
import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/module/detail/chapter/detail_chapter_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailChapterPage extends StatefulWidget {
  @override
  _DetailChapterPageState createState() => _DetailChapterPageState();
}

class _DetailChapterPageState extends State<DetailChapterPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int idChapter;
  double statusBarHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      idChapter = arguments['id'];
    }
    statusBarHeight = MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        Provider.value(
          value: DetailService(),
        ),
        ProxyProvider<DetailService, DetailRepo>(
          update: (context, detailService, _) =>
              DetailRepo(detailService: detailService),
        ),
      ],
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (_controller.isCompleted) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: statusBarHeight),
                  child: ContentChapterWidget(
                    id: idChapter,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -_controller.value * 100),
                child: GestureDetector(
                  onTap: () {
                    print('appbar');
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: statusBarHeight),
                    height: kToolbarHeight,
                    color: AppColor.green,
                    child: Center(
                      child: Text(
                        idChapter.toString(),
                        style: TvStyle.fontAppWithCustom(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ContentChapterWidget extends StatelessWidget {
  final int id;

  ContentChapterWidget({this.id});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DetailChapterBloc(
        detailRepo: Provider.of(context, listen: false),
      ),
      child: Consumer<DetailChapterBloc>(
        builder: (_, bloc, child) => StreamContent(
          detailChapterBloc: bloc,
          id: id,
        ),
      ),
    );
  }
}

class StreamContent extends StatefulWidget {
  final DetailChapterBloc detailChapterBloc;
  final int id;

  StreamContent({this.detailChapterBloc, this.id});

  @override
  _StreamContentState createState() => _StreamContentState();
}

class _StreamContentState extends State<StreamContent> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('load api');
    widget.detailChapterBloc.getContentChapter(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<String>.value(
      value: widget.detailChapterBloc.contentStream,
      initialData: null,
      child: Consumer<String>(
        builder: (_, content, child) {
          if (content == null) {
            return Container(
              height: 170,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColor.green,
                ),
              ),
            );
          }

          if (content.isEmpty) {
            return Container(
              child: Center(
                child: Text(
                  'Chưa có dữ liệu về chap này',
                  style: TvStyle.fontAppWithCustom(),
                ),
              ),
            );
          }

          return SingleChildScrollView(child: Text(content));
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.detailChapterBloc.dispose();
  }
}
