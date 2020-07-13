import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/comic.dart';

class DownloadComicEvent extends BaseEvent{
  final Comic comic;
  final Chapter chapter;

  DownloadComicEvent({this.comic,this.chapter});
}