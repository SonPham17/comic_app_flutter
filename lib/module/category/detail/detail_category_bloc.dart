import 'dart:async';
import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/category_repo.dart';
import 'package:comicappflutter/module/category/detail/detail_category_load_more_event.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class DetailCategoryBloc extends BaseBloc {
  CategoryRepo _categoryRepo;

  String _nextCursor;

  StreamController<Object> _detailCategorySubject =
      BehaviorSubject<Object>();
  Stream<Object> get detailCategoryStream => _detailCategorySubject.stream;
  Sink<Object> get detailCategorySink => _detailCategorySubject.sink;

  DetailCategoryBloc({@required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case DetailCategoryLoadMoreEvent:
        DetailCategoryLoadMoreEvent detailCategoryLoadMoreEvent =
            event as DetailCategoryLoadMoreEvent;
        int id = detailCategoryLoadMoreEvent.id;
        _categoryRepo.getComicByCategory(id, _nextCursor).then((value) {
          _nextCursor = value['next_cursor'];
          detailCategorySink.add(value);
        });
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _detailCategorySubject.close();
  }
}
