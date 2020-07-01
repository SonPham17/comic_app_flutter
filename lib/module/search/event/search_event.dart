import 'package:comicappflutter/base/base_event.dart';

class SearchEvent extends BaseEvent{
  String query;

  SearchEvent({this.query});
}