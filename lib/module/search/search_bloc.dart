import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/search_repo.dart';
import 'package:comicappflutter/module/search/event/search_event.dart';
import 'package:comicappflutter/module/search/event/type_search_event.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:comicappflutter/shared/model/comic.dart';

class SearchBloc extends BaseBloc {
  SearchRepo _searchRepo;

  String _type_search = 'tac_gia';

  StreamController<List<Comic>> _searchSubject = BehaviorSubject<List<Comic>>();

  Stream<List<Comic>> get searchStream => _searchSubject.stream;

  Sink<List<Comic>> get searchSink => _searchSubject.sink;

  StreamController<bool> _btnSearchSubject = BehaviorSubject<bool>();

  Stream<bool> get btnSearchStream => _btnSearchSubject.stream;

  Sink<bool> get btnSearchSink => _btnSearchSubject.sink;

  SearchBloc({@required SearchRepo searchRepo}) : _searchRepo = searchRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case TypeSearchEvent:
        TypeSearchEvent typeSearchEvent = event as TypeSearchEvent;
        _type_search = typeSearchEvent.type;
        break;
      case SearchEvent:
        searchSink.add(null);
        SearchEvent searchEvent = event as SearchEvent;
        if (_type_search == 'tac_gia') {
          _searchRepo.searchByAuthorComicList(searchEvent.query).then(
            (value) {
              btnSearchSink.add(true);
              searchSink.add(value);
            },
          ).catchError((e) {
            btnSearchSink.add(true);
            searchSink.add(List<Comic>());
          });
        } else {
          _searchRepo.searchByNameComicList(searchEvent.query).then((value) {
            searchSink.add(value);
            btnSearchSink.add(true);
          }).catchError((e){
            btnSearchSink.add(true);
            searchSink.add(List<Comic>());
          });
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchSubject.close();
    _btnSearchSubject.close();
  }
}
