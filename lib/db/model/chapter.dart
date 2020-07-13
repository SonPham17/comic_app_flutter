import 'package:floor/floor.dart';

@entity
class ChapterComic {
  @primaryKey
  int idChapter;

  int idComic;
  String nameIdChapter;
  String contentTitleOfChapter;
  String createdAt;
  String updatedAt;
  int vol;
  String content;

  ChapterComic({
    this.idChapter,
    this.idComic,
    this.nameIdChapter,
    this.contentTitleOfChapter,
    this.createdAt,
    this.updatedAt,
    this.vol,
    this.content,
  });


}
