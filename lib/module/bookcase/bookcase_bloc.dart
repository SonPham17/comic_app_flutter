import 'dart:async';

import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/bookcase_repo.dart';
import 'package:comicappflutter/module/detail/comic/update_comic_event.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BookcaseBloc extends BaseBloc {
  BookcaseRepo _bookcaseRepo;

  StreamController<List<Comic>> _bookcaseFollowSubject =
      BehaviorSubject<List<Comic>>();

  Stream<List<Comic>> get bookcaseFollowStream => _bookcaseFollowSubject.stream;

  Sink<List<Comic>> get bookcaseFollowSink => _bookcaseFollowSubject.sink;

  BookcaseBloc({@required BookcaseRepo bookcaseRepo})
      : _bookcaseRepo = bookcaseRepo;

  @override
  void dispatchEvent(BaseEvent baseEvent) {
    switch (baseEvent.runtimeType) {
      case UpdateComicEvent:
        print('update bookcase');
        break;
    }
  }

  void getListComicFollowInDB() {
    _bookcaseRepo
        .getListComicFollowInDB()
        .then((value) => bookcaseFollowSink.add(value));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookcaseFollowSubject.close();
  }
}
