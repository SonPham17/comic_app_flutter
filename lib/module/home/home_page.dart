import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:comicappflutter/module/bookcase/bookcase_page.dart';
import 'package:comicappflutter/module/category/category_page.dart';
import 'package:comicappflutter/module/extension/extension_page.dart';
import 'package:comicappflutter/module/highlight/highlight_page.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';
import 'package:comicappflutter/base/base_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CircularBottomNavigationController _navigationController;
  double bottomNavBarHeight = 60;
  int _currentIndex = 0;
  final List<Widget> _children = [
    HighlightPage(),
    CategoryPage(),
    BookcasePage(),
    ExtensionPage(),
  ];

  final tabItems = List.of([
    TabItem(Icons.home, "Nổi bật", AppColor.green,
        labelStyle: TvStyle.fontApp()),
    TabItem(Icons.apps, "Thể loại", AppColor.green,
        labelStyle: TvStyle.fontApp()),
    TabItem(Icons.bookmark, "Tủ sách", AppColor.green,
        labelStyle: TvStyle.fontApp()),
    TabItem(Icons.dehaze, "Mở rộng", AppColor.green,
        labelStyle: TvStyle.fontApp()),
  ]);

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _children,
        index: _currentIndex,
      ),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        barHeight: bottomNavBarHeight,
        selectedPos: _currentIndex,
        barBackgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (selectedPos) {
          setState(() {
            _currentIndex = selectedPos;
          });
        },
      ),
    );
  }
}
