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
      c.complete(listComicInDB);
    } catch (e) {

    }
    return c.future;
  }
}
