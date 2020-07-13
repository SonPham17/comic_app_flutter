
import 'package:comicappflutter/base/base_event.dart';

class DownloadFinishComicEvent extends BaseEvent{
  String msg;

  DownloadFinishComicEvent({this.msg});
}