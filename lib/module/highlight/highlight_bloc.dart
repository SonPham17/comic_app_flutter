import 'dart:async';
import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class HighlightBloc extends BaseBloc {
  HighlightRepo _highlightRepo;

  StreamController<List<Comic>> _nominateComicSubject =
      BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get nominateComicStream => _nominateComicSubject.stream;
  Sink<List<Comic>> get nominateComicSink => _nominateComicSubject.sink;

  StreamController<List<Comic>> _topViewComicSubject =
  BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get topViewComicStream => _topViewComicSubject.stream;
  Sink<List<Comic>> get topViewComicSink => _topViewComicSubject.sink;

  StreamController<List<Comic>> _newCreatedComicSubject =
      BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get newCreatedComicStream =>
      _newCreatedComicSubject.stream;
  Sink<List<Comic>> get newCreatedComicSink => _newCreatedComicSubject.sink;

  StreamController<List<Comic>> _newUpdateComicSubject =
      BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get newUpdateComicStream => _newUpdateComicSubject.stream;
  Sink<List<Comic>> get newUpdateComicSink => _newUpdateComicSubject.sink;

  StreamController<List<Comic>> _finishedComicSubject =
  BehaviorSubject<List<Comic>>();
  Stream<List<Comic>> get finishedComicStream => _finishedComicSubject.stream;
  Sink<List<Comic>> get finishedComicSink => _finishedComicSubject.sink;

  static HighlightBloc _instance;

  static HighlightBloc getInstance({@required HighlightRepo highlightRepo}) {
    if (_instance == null) {
      _instance = HighlightBloc._internal(highlightRepo: highlightRepo);
    }
    return _instance;
  }

  HighlightBloc._internal({@required HighlightRepo highlightRepo})
      : _highlightRepo = highlightRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    print(event);
  }

  void getNominateComicList() {
    _highlightRepo
        .getNominateComicList()
        .then((value) => nominateComicSink.add(value));
  }

  void getNewUpdateComicList() {
    _highlightRepo
        .getNewUpdateComicList()
        .then((value) => newUpdateComicSink.add(value));
  }

  void getNewCreatedComicList() {
    _highlightRepo
        .getNewCreatedComicList()
        .then((value) => newCreatedComicSink.add(value));
  }

  void getFinishedComicList() {
    _highlightRepo
        .getFinishedComicList()
        .then((value) => finishedComicSink.add(value));
  }

  void getTopViewComicList() {
    _highlightRepo
        .getTopViewComicList()
        .then((value) => topViewComicSink.add(value));
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
    _nominateComicSubject.close();
    _newCreatedComicSubject.close();
    _newUpdateComicSubject.close();
    _topViewComicSubject.close();
    _finishedComicSubject.close();
  }
}
