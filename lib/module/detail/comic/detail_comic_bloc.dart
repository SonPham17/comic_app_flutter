import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DetailComicBloc extends BaseBloc {
  DetailRepo _detailRepo;

  StreamController<List<Chapter>> _chaptersSubject =
      BehaviorSubject<List<Chapter>>();
  Stream<List<Chapter>> get chaptersStream => _chaptersSubject.stream;
  Sink<List<Chapter>> get chapterscSink => _chaptersSubject.sink;

  DetailComicBloc({DetailRepo detailRepo}) : _detailRepo = detailRepo;

  void getChaptersList(int idComic) {
    _detailRepo
        .getChaptersList(idComic)
        .then((value) => chapterscSink.add(value));
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose bloc');
    _chaptersSubject.close();
  }
}
