import 'package:floor/floor.dart';

import 'model/history.dart';

@dao
abstract class HistoryComicDAO{
  @Query('SELECT * FROM HistoryComic')
  Future<List<HistoryComic>> getAllComic();

  @insert
  Future<void> insertComic(HistoryComic historyComic);

  @update
  Future<void> updateComic(HistoryComic historyComic);

  @Query('SELECT * FROM HistoryComic WHERE id = :id')
  Future<HistoryComic> findComicById(int id);

  @delete
  Future<void> deleteComic(HistoryComic historyComic);
}