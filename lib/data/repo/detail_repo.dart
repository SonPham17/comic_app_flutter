import 'dart:isolate';
import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/db/app_database.dart';
import 'package:comicappflutter/db/model/chapter.dart';
import 'package:comicappflutter/db/model/download.dart';
import 'package:comicappflutter/db/model/follow.dart';
import 'package:comicappflutter/db/model/history.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class DetailRepo {
  DetailService _detailService;

  DetailRepo({@required DetailService detailService})
      : _detailService = detailService;

  Future<List<List<Chapter>>> getChaptersList(int idComic) async {
    var c = Completer<List<List<Chapter>>>();
    try {
      var response = await _detailService.getChaptersList(idComic);
      var chapterNew = response.data['story']['chapter_new'];
      if (chapterNew != null) {
        var result = await compute(taskRunner1, response.data);
        c.complete(result);
      } else {
        print('ko co vol');
        c.complete(List<List<Chapter>>());
      }
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<String> getContentChapter(int idChapter) async {
    var c = Completer<String>();
    try {
      var response = await _detailService.getContentChapter(idChapter);
      var contentChapter = response.data['content_chapter'] as List;
      if (contentChapter.length == 0) {
        c.complete('');
      } else {
        c.complete(contentChapter[0]['content']);
      }
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> deleteLikeComic(Comic comic) async {
    var c = Completer<bool>();
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      await database.followComicDao
          .deleteComic(FollowComic.convertComicToFollow(comic));
      c.complete(true);
    } catch (e) {
      c.complete(false);
    }
    return c.future;
  }

  Future<bool> insertLikeComic(Comic comic) async {
    var c = Completer<bool>();
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      await database.followComicDao
          .insertComic(FollowComic.convertComicToFollow(comic));
      c.complete(true);
    } catch (e) {
      c.complete(false);
    }
    return c.future;
  }

  Future<List<ChapterComic>> getChaptersListInDB(int idComic) async {
    var c = Completer<List<ChapterComic>>();
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      print('get chapterinDB');
      database.chapterComicDao.findChapterByComic(idComic).then((value) {
        if (value != null) {
          c.complete(value);
        } else {
          c.complete(null);
        }
      });
    } catch (e) {
      c.complete(null);
      print('loi get chapterinDB $e');
    }
    return c.future;
  }

  Future<bool> insertDownloadComic(Comic comic) async {
    var c = Completer<bool>();
    print('insertDownloadComic');
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      await database.downloadComicDao
          .insertComic(DownloadComic.convertComicToDownload(comic));
      c.complete(true);
    } catch (e) {
      print('loi download $e');
      c.complete(false);
    }
    return c.future;
  }

  Future<bool> insertDownloadChapter(ChapterComic chapterComic) async {
    var c = Completer<bool>();
    print('insertDownloadComic');
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      await database.chapterComicDao.insertComic(chapterComic);
      c.complete(true);
    } catch (e) {
      print('loi download $e');
      c.complete(false);
    }
    return c.future;
  }

  Future<void> insertHistoryComic(Comic comic) async {
    print('insert history comic');
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      await database.historyComicDao
          .insertComic(HistoryComic.convertComicToHistory(comic));
    } catch (e) {
      print('Loi roi` $e');
    }
  }

  Future<Comic> findComicFollowInDB(int id) async {
    print('id= $id');
    var c = Completer<Comic>();
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      var followComic = await database.followComicDao.findComicById(id);
      if (followComic == null) {
        c.complete(null);
      } else {
        c.complete(Comic.convertFollowToComic(followComic));
      }
    } catch (e) {
      print('Loi nay $e');
    }
    return c.future;
  }

  Future<bool> findComicChapterInDB(int idChapter) async {
    var c = Completer<bool>();
    final database =
        await $FloorAppDatabase.databaseBuilder('comic_database.db').build();
    try {
      var chapterComic =
          await database.chapterComicDao.findComicById(idChapter);
      if (chapterComic == null) {
        c.complete(false);
      } else {
        c.complete(true);
      }
    } catch (e) {
      print('Loi nay $e');
    }
    return c.future;
  }

  static List<List<Chapter>> taskRunner1(dynamic data) {
    var totalVol = data['story']['chapter_new']['vol'];
    var chapters = Chapter.parseChaptersList(data);
    var listChapters = List<List<Chapter>>();
    for (int i = 1; i <= totalVol; i++) {
      var listChaptersByVol = List<Chapter>();
      for (int j = 0; j < chapters.length; j++) {
        if (chapters[j].vol == i) {
          listChaptersByVol.add(chapters[j]);
        }
      }
      listChapters.add(listChaptersByVol);
    }
    return listChapters;
  }
}
