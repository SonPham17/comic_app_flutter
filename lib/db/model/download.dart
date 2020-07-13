
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:floor/floor.dart';

@entity
class DownloadComic{
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

  DownloadComic({
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

  factory DownloadComic.convertComicToDownload(Comic comic) => DownloadComic(
    id: comic.id,
    name: comic.name,
    introduce: comic.introduce,
    author: comic.author,
    idThread: comic.idThread,
    countChapter: comic.countChapter,
    finish: comic.finish,
    image: comic.image,
    nominatedMonth: comic.nominatedMonth,
    avgRate: comic.avgRate,
    chinaName: comic.chinaName,
    timeFix: comic.timeFix,
    convertMonth: comic.convertMonth,
    tags: comic.tags,
    modPassMoney: comic.modPassMoney,
    countNominated: comic.countNominated,
  );
}