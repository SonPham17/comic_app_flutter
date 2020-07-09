import 'package:floor/floor.dart';

@entity
class Comic {
  @primaryKey
  int id;

  String name;
  String introduce;
  String author;
  String idThread;
  int countChapter;
  int finish;
  String image;
  int nominatedMonth;
  double avgRate;
  String chinaName;
  int timeFix;
  int convertMonth;
  String tags;
  int modPassMoney;
  int countNominated;
  bool isLiked;

  Comic({
    this.id,
    this.name,
    this.introduce,
    this.author,
    this.idThread,
    this.countChapter,
    this.finish,
    this.image,
    this.nominatedMonth,
    this.avgRate,
    this.chinaName,
    this.timeFix,
    this.convertMonth,
    this.tags,
    this.modPassMoney,
    this.countNominated,
    this.isLiked,
  });

  static List<Comic> parseComicList(map) {
    var list = map['data'] as List;
    return list.map((product) => Comic.fromJson(product)).toList();
  }

  static List<Comic> parseComicListBySearch(map) {
    var list = map['stories'] as List;
    return list.map((product) => Comic.fromJson(product)).toList();
  }

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        id: json["id"],
        name: json["name"],
        introduce: json["introduce"],
        author: json["author"],
        idThread: json["id_thread"],
        countChapter: json["count_chapter"],
        finish: json["finish"],
        image: json["image"],
        nominatedMonth: json["nominated_month"],
        avgRate: json["avg_rate"].toDouble(),
        chinaName: json["china_name"],
        timeFix: json["time_fix"],
        convertMonth: json["convert_month"],
        tags: json["tags"],
        modPassMoney: json["mod_pass_money"],
        countNominated: json["count_nominated"],
        isLiked: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "introduce": introduce,
        "author": author,
        "id_thread": idThread,
        "count_chapter": countChapter,
        "finish": finish,
        "image": image,
        "nominated_month": nominatedMonth,
        "avg_rate": avgRate,
        "china_name": chinaName,
        "time_fix": timeFix,
        "convert_month": convertMonth,
        "tags": tags,
        "mod_pass_money": modPassMoney,
        "count_nominated": countNominated,
      };
}
