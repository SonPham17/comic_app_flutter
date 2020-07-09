import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/shared/model/comic.dart';

class LikeComicEvent extends BaseEvent{
  Comic comic;

  LikeComicEvent({this.comic});
}