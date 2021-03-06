import 'package:bot_toast/bot_toast.dart';
import 'package:comicappflutter/module/category/detail/detail_category_page.dart';
import 'package:comicappflutter/module/detail/chapter/detail_chapter_page.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_page.dart';
import 'package:comicappflutter/module/search/search_page.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'module/detail/chapter/detail_chapter_db_page.dart';
import 'module/highlight/load_more/load_more_page.dart';
import 'module/splash/splash.dart';
import 'module/home/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Novel Galaxy',
      theme: ThemeData(
        primarySwatch: AppColor.green,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/detail/comic_page': (context) => DetailComicPage(),
        '/detail/category_page': (context) => DetailCategoryPage(),
        '/detail/chapter_page': (context) => DetailChapterPage(),
        '/detail/chapter_db_page': (context) => DetailChapterDBPage(),
        '/load_more': (context) => LoadMorePage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
