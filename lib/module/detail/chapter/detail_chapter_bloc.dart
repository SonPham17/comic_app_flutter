import 'dart:async';
import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class DetailChapterBloc extends BaseBloc {
  DetailRepo _detailRepo;

  DetailChapterBloc({@required DetailRepo detailRepo})
      : _detailRepo = detailRepo;

  StreamController<String> _contentSubject = BehaviorSubject<String>();

  Stream<String> get contentStream => _contentSubject.stream;

  Sink<String> get contentSink => _contentSubject.sink;

  void getContentChapter(int id) {
    print(id);
    _detailRepo.getContentChapter(id).then((value) {
      if (!_contentSubject.isClosed) {
        contentSink.add(value);
      }
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {}

  @override
  void dispose() {
    super.dispose();
    _contentSubject.close();
  }
}
