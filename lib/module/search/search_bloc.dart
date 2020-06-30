import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/search_repo.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:comicappflutter/shared/model/comic.dart';

class SearchBloc extends BaseBloc {
  SearchRepo _searchRepo;

  StreamController<List<Comic>> _searchSubject = BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get searchStream => _searchSubject.stream;
  Sink<List<Comic>> get searchSink => _searchSubject.sink;

  static SearchBloc _instance;

  static SearchBloc getInstance({@required SearchRepo searchRepo}){
    if(_instance ==null){
      _instance = SearchBloc._internal(searchRepo: searchRepo);
    }
    return _instance;
  }

  SearchBloc._internal({@required SearchRepo searchRepo})
      : _searchRepo = searchRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }

  @override
  void dispose() {
    super.dispose();
    _searchSubject.close();
  }
}
