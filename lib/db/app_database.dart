import 'dart:async';

import 'package:comicappflutter/db/comic_dao.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1,entities: [Comic])
abstract class AppDatabase extends FloorDatabase{
  ComicDAO get comicDao;
}