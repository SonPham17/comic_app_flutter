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

  static List<Chapter> parseChaptersList(map) {
    var list = map['chapters'] as List;
    return list.map((chapter) => Chapter.fromJson(chapter)).toList();
  }
}