import 'dart:async';

import 'package:comicappflutter/data/remote/bookcase_service.dart';
import 'package:comicappflutter/db/app_database.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:flutter/widgets.dart';

class BookcaseRepo {
  BookcaseService _bookcaseService;

  BookcaseRepo({@required BookcaseService bookcaseService})
      : _bookcaseService = bookcaseService;

  Future<List<Comic>> getListComicFollowInDB() async {
    var c = Completer<List<Comic>>();
    final database =
    await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      var listComicInDB = await database.followComicDao.getAllComic();
      c.complete(Comic.parseComicListByFollow(listComicInDB));
    } catch (e) {

    }
    return c.future;
  }

  Future<List<Comic>> getListComicHistoryInDB() async {
    var c = Completer<List<Comic>>();
    final database =
    await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      var listComicInDB = await database.historyComicDao.getAllComic();
      c.complete(Comic.parseComicListByHistory(listComicInDB));
    } catch (e) {
      print('loi history $e');
    }
    return c.future;
  }

  Future<List<Comic>> getListComicDownloadInDB() async {
    var c = Completer<List<Comic>>();
    final database =
    await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      var listComicInDB = await database.downloadComicDao.getAllComic();
      c.complete(Comic.parseComicListByDownload(listComicInDB));
    } catch (e) {
      print('loi donwload $e');
    }
    return c.future;
  }
}
