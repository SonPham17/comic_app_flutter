import 'package:comicappflutter/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'module/splash/splash.dart';
import 'module/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comics Reader',
      theme: ThemeData(
        primarySwatch: AppColor.green,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
