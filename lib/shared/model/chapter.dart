import 'package:comicappflutter/db/model/chapter.dart';

class Chapter{
  int id;
  int chapterId;
  String nameIdChapter;
  String url;
  String contentTitleOfChapter;
  int vol;
  int storyId;
  String createdAt;
  String updatedAt;

  Chapter({
    this.id,
    this.chapterId,
    this.nameIdChapter,
    this.url,
    this.contentTitleOfChapter,
    this.vol,
    this.storyId,
    this.createdAt,
    this.updatedAt,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    chapterId: json["chapter_id"],
    nameIdChapter: json["name_id_chapter"],
    url: json["url"],
    contentTitleOfChapter: json["content_title_of_chapter"],
    vol: json["vol"],
    storyId: json["story_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  factory Chapter.fromDB(ChapterComic chapterComic) => Chapter(
    id: chapterComic.idChapter,
    chapterId: chapterComic.idChapter,
    nameIdChapter: chapterComic.nameIdChapter,
    url: '',
    contentTitleOfChapter: chapterComic.contentTitleOfChapter,
    vol: chapterComic.vol,
    storyId: 1,
    createdAt: chapterComic.createdAt,
    updatedAt: chapterComic.updatedAt,
  );

  static List<Chapter> parseChaptersList(map) {
    var list = map['chapters'] as List;
    return list.map((chapter) => Chapter.fromJson(chapter)).toList();
  }

  static List<Chapter> parseChaptersListFromDB(List<ChapterComic> data) {
    return data.map((chapter) => Chapter.fromDB(chapter)).toList();
  }
}