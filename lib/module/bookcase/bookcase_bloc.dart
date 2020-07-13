import 'dart:async';

import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/bookcase_repo.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BookcaseBloc extends BaseBloc {
  BookcaseRepo _bookcaseRepo;

  StreamController<List<Comic>> _bookcaseFollowSubject =
      BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get bookcaseFollowStream => _bookcaseFollowSubject.stream;
  Sink<List<Comic>> get bookcaseFollowSink => _bookcaseFollowSubject.sink;

  StreamController<List<Comic>> _bookcaseHistorySubject =
  BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get bookcaseHistoryStream => _bookcaseHistorySubject.stream;
  Sink<List<Comic>> get bookcaseHistorySink => _bookcaseHistorySubject.sink;

  StreamController<List<Comic>> _bookcaseDownloadSubject =
  BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get bookcaseDownloadStream => _bookcaseDownloadSubject.stream;
  Sink<List<Comic>> get bookcaseDownloadSink => _bookcaseDownloadSubject.sink;

  BookcaseBloc({@required BookcaseRepo bookcaseRepo})
      : _bookcaseRepo = bookcaseRepo;

  @override
  void dispatchEvent(BaseEvent baseEvent) {

  }

  void getListComicFollowInDB() {
    _bookcaseRepo
        .getListComicFollowInDB()
        .then((value) => bookcaseFollowSink.add(value));
  }

  void getListComicHistoryInDB() {
    _bookcaseRepo
        .getListComicHistoryInDB()
        .then((value) => bookcaseHistorySink.add(value));
  }

  void getListComicDownloadInDB() {
    _bookcaseRepo
        .getListComicDownloadInDB()
        .then((value) => bookcaseDownloadSink.add(value));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookcaseFollowSubject.close();
    _bookcaseHistorySubject.close();
    _bookcaseDownloadSubject.close();
  }
}
