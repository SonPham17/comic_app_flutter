
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/shared/model/comic.dart';

class HistoryComicEvent extends BaseEvent{
  final Comic comic;

  HistoryComicEvent({this.comic});
}