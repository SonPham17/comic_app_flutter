import 'package:comicappflutter/db/model/chapter.dart';
import 'package:floor/floor.dart';

@dao
abstract class ChapterComicDAO{
  @Query('SELECT * FROM ChapterComic')
  Future<List<ChapterComic>> getAllComic();

  @insert
  Future<void> insertComic(ChapterComic chapterComic);

  @update
  Future<void> updateComic(ChapterComic chapterComic);

  @Query('SELECT * FROM ChapterComic WHERE idChapter = :idChapter')
  Future<ChapterComic> findComicById(int idChapter);

  @Query('SELECT * FROM ChapterComic WHERE idComic = :idComic')
  Future<List<ChapterComic>> findChapterByComic(int idComic);
}