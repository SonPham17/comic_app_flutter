import 'dart:async';

import 'package:comicappflutter/db/chapter_comic_dao.dart';
import 'package:comicappflutter/db/download_comic_dao.dart';
import 'package:comicappflutter/db/follow_comic_dao.dart';
import 'package:comicappflutter/db/history_comic_dao.dart';
import 'package:comicappflutter/db/model/chapter.dart';
import 'package:comicappflutter/db/model/download.dart';
import 'package:comicappflutter/db/model/follow.dart';
import 'package:comicappflutter/db/model/history.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1,entities: [FollowComic,HistoryComic,DownloadComic,ChapterComic])
abstract class AppDatabase extends FloorDatabase{
  FollowComicDAO get followComicDao;
  HistoryComicDAO get historyComicDao;
  DownloadComicDAO get downloadComicDao;
  ChapterComicDAO get chapterComicDao;
}