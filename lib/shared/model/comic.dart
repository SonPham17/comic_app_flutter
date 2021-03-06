import 'package:comicappflutter/db/model/download.dart';
import 'package:comicappflutter/db/model/follow.dart';
import 'package:comicappflutter/db/model/history.dart';

class Comic {
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
  });

  static List<Comic> parseComicList(map) {
    var list = map['data'] as List;
    return list.map((product) => Comic.fromJson(product)).toList();
  }

  static List<Comic> parseComicListBySearch(map) {
    var list = map['stories'] as List;
    return list.map((product) => Comic.fromJson(product)).toList();
  }

  static List<Comic> parseComicListByFollow(listFollow){
    var list = listFollow as List;
    return list.map((followComic) => Comic.convertFollowToComic(followComic)).toList();
  }

  static List<Comic> parseComicListByHistory(listFollow){
    var list = listFollow as List;
    return list.map((historyComic) => Comic.convertHistoryToComic(historyComic)).toList();
  }

  static List<Comic> parseComicListByDownload(listFollow){
    var list = listFollow as List;
    return list.map((downloadComic) => Comic.convertDownloadToComic(downloadComic)).toList();
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
      );

  factory Comic.convertFollowToComic(FollowComic followComic) => Comic(
        id: followComic.id,
        name: followComic.name,
        introduce: followComic.introduce,
        author: followComic.author,
        idThread: followComic.idThread,
        countChapter: followComic.countChapter,
        finish: followComic.finish,
        image: followComic.image,
        nominatedMonth: followComic.nominatedMonth,
        avgRate: followComic.avgRate,
        chinaName: followComic.chinaName,
        timeFix: followComic.timeFix,
        convertMonth: followComic.convertMonth,
        tags: followComic.tags,
        modPassMoney: followComic.modPassMoney,
        countNominated: followComic.countNominated,
      );

  factory Comic.convertHistoryToComic(HistoryComic historyComic) => Comic(
    id: historyComic.id,
    name: historyComic.name,
    introduce: historyComic.introduce,
    author: historyComic.author,
    idThread: historyComic.idThread,
    countChapter: historyComic.countChapter,
    finish: historyComic.finish,
    image: historyComic.image,
    nominatedMonth: historyComic.nominatedMonth,
    avgRate: historyComic.avgRate,
    chinaName: historyComic.chinaName,
    timeFix: historyComic.timeFix,
    convertMonth: historyComic.convertMonth,
    tags: historyComic.tags,
    modPassMoney: historyComic.modPassMoney,
    countNominated: historyComic.countNominated,
  );

  factory Comic.convertDownloadToComic(DownloadComic downloadComic) => Comic(
    id: downloadComic.id,
    name: downloadComic.name,
    introduce: downloadComic.introduce,
    author: downloadComic.author,
    idThread: downloadComic.idThread,
    countChapter: downloadComic.countChapter,
    finish: downloadComic.finish,
    image: downloadComic.image,
    nominatedMonth: downloadComic.nominatedMonth,
    avgRate: downloadComic.avgRate,
    chinaName: downloadComic.chinaName,
    timeFix: downloadComic.timeFix,
    convertMonth: downloadComic.convertMonth,
    tags: downloadComic.tags,
    modPassMoney: downloadComic.modPassMoney,
    countNominated: downloadComic.countNominated,
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
