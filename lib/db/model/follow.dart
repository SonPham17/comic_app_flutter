import 'package:floor/floor.dart';

@entity
class FollowComic{
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

  FollowComic({
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
}