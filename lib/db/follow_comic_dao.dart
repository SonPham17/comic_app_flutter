import 'package:comicappflutter/db/model/follow.dart';
import 'package:floor/floor.dart';
import 'package:comicappflutter/shared/model/comic.dart';

@dao
abstract class FollowComicDAO{
  @Query('SELECT * FROM FollowComic')
  Future<List<FollowComic>> getAllComic();

  @insert
  Future<int> insertComic(FollowComic followComic);

  @update
  Future<int> updateComic(FollowComic followComic);

  @Query('SELECT * FROM FollowComic WHERE id = :id')
  Future<FollowComic> findComicById(int id);

  @delete
  Future<int> deleteComic(FollowComic followComic);
}