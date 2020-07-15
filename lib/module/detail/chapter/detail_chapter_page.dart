import 'package:bot_toast/bot_toast.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/module/detail/chapter/detail_chapter_bloc.dart';
import 'package:comicappflutter/module/detail/chapter/download_comic_event.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/background_style.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/font_style.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'download_finish_comic_event.dart';

class DetailChapterPage extends StatefulWidget {
  @override
  _DetailChapterPageState createState() => _DetailChapterPageState();
}

class _DetailChapterPageState extends State<DetailChapterPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int idChapter;
  Comic comic;
  Chapter chapter;
  double statusBarHeight;

  double _value = 14;
  String fontStyle = 'Sriracha';
  Color backgroundStyleColor = Colors.white;
  Color textStyleColor = Colors.black;
  double widthScreen;

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
    widthScreen = (MediaQuery.of(context).size.width) / 9;
    var arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      idChapter = arguments['id'];
      comic = arguments['comic'];
      chapter = arguments['chapter'];
    }
    statusBarHeight = MediaQuery.of(context).padding.top;
  }

  @override
  Widget build(BuildContext context) {
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
        body: Provider(
          create: (context) => DetailChapterBloc(
            detailRepo: Provider.of(
              context,
              listen: false,
            ),
          ),
          child: Consumer<DetailChapterBloc>(
            builder: (_, bloc, child) => AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Stack(
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
                      color: backgroundStyleColor,
                      padding: EdgeInsets.only(
                          top: statusBarHeight, left: 5, right: 5),
                      child: ContentChapterWidget(
                        id: idChapter,
                        sizeText: _value,
                        fontStyle: fontStyle,
                        textColor: textStyleColor,
                        backgroundStyleColor: backgroundStyleColor,
                        detailChapterBloc: bloc,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -_controller.value * 100),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: statusBarHeight + 10, left: widthScreen),
                      height: widthScreen,
                      width: widthScreen,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.green,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                  BlocListener<DetailChapterBloc>(
                    listener: handleEvent,
                    child: Transform.translate(
                      offset: Offset(0, -_controller.value * 100),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: statusBarHeight + 10, left: widthScreen * 4),
                        height: widthScreen,
                        width: widthScreen,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.green,
                        ),
                        child: StreamProvider<bool>.value(
                          value: bloc.chapterIsExistStream,
                          initialData: true,
                          child: Consumer<bool>(
                            builder: (_, isExist, child) {
                              if (isExist) {
                                return FloatingActionButton(
                                  backgroundColor: Colors.black38,
                                  onPressed: null,
                                  child: Icon(
                                    LineAwesomeIcons.cloud_download,
                                    color: AppColor.white,
                                  ),
                                );
                              } else {
                                return FloatingActionButton(
                                  backgroundColor: AppColor.green,
                                  onPressed: () {
                                    bloc.event.add(DownloadComicEvent(
                                      comic: comic,
                                      chapter: chapter,
                                    ));
                                  },
                                  child: Icon(
                                    LineAwesomeIcons.cloud_download,
                                    color: AppColor.white,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -_controller.value * 100),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: statusBarHeight + 10, left: widthScreen * 7),
                      height: widthScreen,
                      width: widthScreen,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.green,
                      ),
                      child: InkWell(
                        onTap: () {
                          showMaterialModalBottomSheet(
                            duration: Duration(milliseconds: 300),
                            context: context,
                            builder: (context, scrollController) =>
                                _buildBottomSheet(scrollController),
                          );
                        },
                        child: Icon(
                          LineAwesomeIcons.font,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleEvent(BaseEvent event) {
    if (event is DownloadFinishComicEvent) {
      BotToast.showText(text: event.msg);
    }
  }

  Widget _buildBottomSheet(ScrollController scrollController) {
    return StatefulBuilder(
      builder: (context, setModalState) => Container(
        height: 170,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: listBackgroundStyle
                    .map((item) => InkWell(
                          onTap: () {
                            setModalState(
                              () {
                                var index = listBackgroundStyle.indexWhere(
                                    (element) => element.isSelected == true);
                                listBackgroundStyle[index].isSelected = false;
                                item.isSelected = true;
                              },
                            );
                            setState(() {
                              backgroundStyleColor = item.backgroundColor;
                              textStyleColor = item.textColor;
                            });
                          },
                          child: Icon(
                            item.iconData,
                            color:
                                item.isSelected ? AppColor.green : Colors.black,
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                children: listFontStyle
                    .map((item) => InkWell(
                          onTap: () {
                            setModalState(
                              () {
                                var index = listFontStyle.indexWhere(
                                    (element) => element.isSelected == true);
                                listFontStyle[index].isSelected = false;
                                item.isSelected = true;
                              },
                            );
                            setState(() {
                              fontStyle = item.name;
                            });
                          },
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                item.name,
                                style: GoogleFonts.getFont(
                                  item.name,
                                  fontSize: 15,
                                  color: item.isSelected
                                      ? AppColor.green
                                      : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.text_fields,
                    size: 14,
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.green[700],
                        inactiveTrackColor: Colors.green[100],
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4.0,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        thumbColor: Colors.greenAccent,
                        overlayColor: Colors.green.withAlpha(32),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 28.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Colors.green[700],
                        inactiveTickMarkColor: Colors.green[100],
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.greenAccent,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: _value,
                        min: 10,
                        max: 60,
                        divisions: 100,
                        label: '$_value',
                        onChanged: (value) {
                          setState(() {
                            print('setState');
                          });
                          setModalState(
                            () {
                              _value = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Icon(
                    Icons.text_fields,
                    size: 32,
                  ),
                ],
              ),
            ),
          ],
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
  final double sizeText;
  final String fontStyle;
  final Color textColor;
  final Color backgroundStyleColor;
  final DetailChapterBloc detailChapterBloc;

  ContentChapterWidget({
    this.id,
    this.sizeText,
    this.fontStyle,
    this.textColor,
    this.backgroundStyleColor,
    this.detailChapterBloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamContent(
      detailChapterBloc: detailChapterBloc,
      id: id,
      sizeText: sizeText,
      fontStyle: fontStyle,
      textColor: textColor,
      backgroundStyleColor: backgroundStyleColor,
    );
  }
}

class StreamContent extends StatefulWidget {
  final DetailChapterBloc detailChapterBloc;
  final int id;
  final double sizeText;
  final String fontStyle;
  final Color textColor;
  final Color backgroundStyleColor;

  StreamContent({
    this.detailChapterBloc,
    this.id,
    this.sizeText,
    this.fontStyle,
    this.textColor,
    this.backgroundStyleColor,
  });

  @override
  _StreamContentState createState() => _StreamContentState();
}

class _StreamContentState extends State<StreamContent> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.detailChapterBloc.getContentChapter(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild content');
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
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.green),
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

          return SingleChildScrollView(
            child: Container(
              color: widget.backgroundStyleColor,
              child: Text(
                content,
                style: GoogleFonts.getFont(
                  widget.fontStyle,
                  fontSize: widget.sizeText,
                  color: widget.textColor,
                ),
              ),
            ),
          );
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

List<FontStyleModel> listFontStyle = [
  FontStyleModel(name: 'Sriracha', isSelected: true),
  FontStyleModel(name: 'Roboto', isSelected: false),
  FontStyleModel(name: 'Bangers', isSelected: false),
  FontStyleModel(name: 'Montserrat', isSelected: false),
  FontStyleModel(name: 'Roboto Mono', isSelected: false),
  FontStyleModel(name: 'Oswald', isSelected: false),
  FontStyleModel(name: 'Merriweather', isSelected: false),
  FontStyleModel(name: 'Playfair Display', isSelected: false),
  FontStyleModel(name: 'Muli', isSelected: false),
];

List<BackgroundStyleModel> listBackgroundStyle = [
  BackgroundStyleModel(
    iconData: Icons.lightbulb_outline,
    isSelected: true,
    textColor: Colors.black,
    backgroundColor: Colors.white,
  ),
  BackgroundStyleModel(
    iconData: Icons.star_half,
    isSelected: false,
    textColor: Colors.black38,
    backgroundColor: Colors.lightBlue,
  ),
  BackgroundStyleModel(
    iconData: Icons.brightness_2,
    isSelected: false,
    textColor: Colors.white,
    backgroundColor: Colors.black,
  ),
];
