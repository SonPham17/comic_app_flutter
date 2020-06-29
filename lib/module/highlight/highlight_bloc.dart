import 'dart:async';
import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:comicappflutter/module/highlight/load_more/event/load_more_event.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class HighlightBloc extends BaseBloc {
  HighlightRepo _highlightRepo;

  String _nextCursorTopView = '';
  String _nextCursorNewCreated = '';
  String _nextCursorNewUpdate = '';
  String _nextCursorFinishedComic = '';

  StreamController<Object> _nominateComicSubject = BehaviorSubject<Object>();

  Stream<Object> get nominateComicStream => _nominateComicSubject.stream;

  Sink<Object> get nominateComicSink => _nominateComicSubject.sink;

  StreamController<Object> _topViewComicSubject = BehaviorSubject<Object>();

  Stream<Object> get topViewComicStream => _topViewComicSubject.stream;

  Sink<Object> get topViewComicSink => _topViewComicSubject.sink;

  StreamController<Object> _newCreatedComicSubject = BehaviorSubject<Object>();

  Stream<Object> get newCreatedComicStream => _newCreatedComicSubject.stream;

  Sink<Object> get newCreatedComicSink => _newCreatedComicSubject.sink;

  StreamController<Object> _newUpdateComicSubject = BehaviorSubject<Object>();

  Stream<Object> get newUpdateComicStream => _newUpdateComicSubject.stream;

  Sink<Object> get newUpdateComicSink => _newUpdateComicSubject.sink;

  StreamController<Object> _finishedComicSubject = BehaviorSubject<Object>();

  Stream<Object> get finishedComicStream => _finishedComicSubject.stream;

  Sink<Object> get finishedComicSink => _finishedComicSubject.sink;

  HighlightBloc({HighlightRepo highlightRepo}) : _highlightRepo = highlightRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case LoadMoreEvent:
        LoadMoreEvent loadMoreEvent = event as LoadMoreEvent;
        int type = loadMoreEvent.type;
        switch(type){
          case 1:
            getTopViewComicList();
            break;
          case 2:
            getNewUpdateComicList();
            break;
          case 3:
            getNewCreatedComicList();
            break;
          case 4:
            getFinishedComicList();
            break;
        }
        break;
    }
  }

  void getNominateComicList() {
    _highlightRepo
        .getNominateComicList()
        .then((value) => nominateComicSink.add(value));
  }

  void getNewUpdateComicList() {
    _highlightRepo.getNewUpdateComicList(_nextCursorNewUpdate).then((value) {
      _nextCursorNewUpdate = value['next_cursor'];
      newUpdateComicSink.add(value);
    });
  }

  void getNewCreatedComicList() {
    _highlightRepo.getNewCreatedComicList(_nextCursorNewCreated).then((value) {
      _nextCursorNewCreated = value['next_cursor'];
      newCreatedComicSink.add(value);
    });
  }

  void getFinishedComicList() {
    _highlightRepo.getFinishedComicList(_nextCursorFinishedComic).then((value) {
      _nextCursorFinishedComic = value['next_cursor'];
      finishedComicSink.add(value);
    });
  }

  void getTopViewComicList() {
    print('Next Cursor=   $_nextCursorTopView');
    _highlightRepo.getTopViewComicList(_nextCursorTopView).then((value) {
      _nextCursorTopView = value['next_cursor'];
      topViewComicSink.add(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('highlight dispose');
    _nominateComicSubject.close();
    _newCreatedComicSubject.close();
    _newUpdateComicSubject.close();
    _topViewComicSubject.close();
    _finishedComicSubject.close();
  }
}
