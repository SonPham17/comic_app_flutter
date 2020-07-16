import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/background_style.dart';
import 'package:comicappflutter/shared/model/font_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DetailChapterDBPage extends StatefulWidget {
  @override
  _DetailChapterDBPageState createState() => _DetailChapterDBPageState();
}

class _DetailChapterDBPageState extends State<DetailChapterDBPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ScrollController _scrollController;

  double statusBarHeight;

  String content;
  String nameIdChapter;
  String contentTitleOfChapter;

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
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = ModalRoute.of(context).settings.arguments as Map;
    widthScreen = (MediaQuery.of(context).size.width) / 9;
    statusBarHeight = MediaQuery.of(context).padding.top;
    if (arguments != null) {
      content = arguments['content'];
      nameIdChapter = arguments['name_id_chapter'];
      contentTitleOfChapter = arguments['content_title_of_chapter'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: AnimatedBuilder(
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
                padding:
                    EdgeInsets.only(top: statusBarHeight, left: 5, right: 5),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    color: backgroundStyleColor,
                    child: Column(
                      children: <Widget>[
                        Text(
                          '$nameIdChapter: $contentTitleOfChapter',
                          style: GoogleFonts.getFont(
                            fontStyle,
                            fontSize: _value + 7,
                            color: textStyleColor,
                          ),
                        ),
                        Text(
                          content,
                          style: GoogleFonts.getFont(
                            fontStyle,
                            fontSize: _value,
                            color: textStyleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
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
    );
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
