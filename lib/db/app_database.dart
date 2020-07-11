import 'dart:async';

import 'package:comicappflutter/db/follow_comic_dao.dart';
import 'package:comicappflutter/db/model/follow.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1,entities: [FollowComic])
abstract class AppDatabase extends FloorDatabase{
  FollowComicDAO get followComicDao;
}