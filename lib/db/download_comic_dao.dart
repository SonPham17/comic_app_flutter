import 'package:comicappflutter/db/model/download.dart';
import 'package:floor/floor.dart';

@dao
abstract class DownloadComicDAO{
  @Query('SELECT * FROM DownloadComic')
  Future<List<DownloadComic>> getAllComic();

  @insert
  Future<void> insertComic(DownloadComic downloadComic);

  @update
  Future<void> updateComic(DownloadComic downloadComic);

  @Query('SELECT * FROM DownloadComic WHERE id = :id')
  Future<DownloadComic> findComicById(int id);
}