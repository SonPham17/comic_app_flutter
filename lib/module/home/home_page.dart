import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:comicappflutter/shared/app_color.dart';
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
  int selectedPos = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  final tabItems = List.of([
    TabItem(Icons.home, "Nổi bật", AppColor.green,
        labelStyle: GoogleFonts.getFont('Pacifico')),
    TabItem(Icons.apps, "Thể loại", AppColor.green,
        labelStyle: GoogleFonts.getFont('Pacifico')),
    TabItem(Icons.bookmark, "Tủ sách", AppColor.green,
        labelStyle: GoogleFonts.getFont('Pacifico')),
    TabItem(Icons.dehaze, "Mở rộng", AppColor.green,
        labelStyle: GoogleFonts.getFont('Pacifico')),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: AppColor.green),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircularBottomNavigation(
              tabItems,
              controller: _navigationController,
              barHeight: bottomNavBarHeight,
              barBackgroundColor: Colors.white,
              animationDuration: Duration(milliseconds: 300),
              selectedCallback: (int selectedPos) {
                setState(() {
                  this.selectedPos = selectedPos;
                  print(_navigationController.value);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Color selectedColor = tabItems[selectedPos].circleColor;
    String slogan;
    switch (selectedPos) {
      case 0:
        slogan = "Familly, Happiness, Food";
        break;
      case 1:
        slogan = "Find, Check, Use";
        break;
      case 2:
        slogan = "Receive, Review, Rip";
        break;
      case 3:
        slogan = "Noise, Panic, Ignore";
        break;
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: selectedColor,
        child: Center(
          child: Text(
            slogan,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      onTap: () {
        if (_navigationController.value == tabItems.length - 1) {
          _navigationController.value = 0;
        } else {
          _navigationController.value++;
        }
      },
    );
  }
}
