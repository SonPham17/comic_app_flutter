import 'package:comicappflutter/db/model/follow.dart';
import 'package:floor/floor.dart';

@dao
abstract class FollowComicDAO{
  @Query('SELECT * FROM FollowComic')
  Future<List<FollowComic>> getAllComic();

  @insert
  Future<void> insertComic(FollowComic followComic);

  @update
  Future<void> updateComic(FollowComic followComic);

  @Query('SELECT * FROM FollowComic WHERE id = :id')
  Future<FollowComic> findComicById(int id);

  @delete
  Future<void> deleteComic(FollowComic followComic);
}