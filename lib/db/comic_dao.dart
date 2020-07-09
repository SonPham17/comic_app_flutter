import 'package:floor/floor.dart';
import 'package:comicappflutter/shared/model/comic.dart';

@dao
abstract class ComicDAO{
  @Query('SELECT * FROM Comic')
  Future<List<Comic>> getAllComic();

  @insert
  Future<int> insertComic(Comic comic);

  @update
  Future<int> updateComic(Comic comic);

  @Query('SELECT * FROM Comic WHERE id = :id')
  Future<Comic> findComicById(int id);

  @delete
  Future<int> deleteComic(Comic comic);
}