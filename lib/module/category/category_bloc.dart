import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/category_repo.dart';
import 'package:comicappflutter/shared/model/category.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CategoryBloc extends BaseBloc {
  CategoryRepo _categoryRepo;

  StreamController<List<Category>> _categorySubject =
      BehaviorSubject<List<Category>>();

  Stream<List<Category>> get categoryStream => _categorySubject.stream;

  Sink<List<Category>> get categorySink => _categorySubject.sink;

  static CategoryBloc _instance;

  static CategoryBloc getInstance({@required CategoryRepo categoryRepo}) {
    if (_instance == null) {
      _instance = CategoryBloc._internal(categoryRepo: categoryRepo);
    }
    return _instance;
  }

  CategoryBloc._internal({@required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }

  void getCategory() {
    _categoryRepo.getCategory().then((value) => categorySink.add(value));
  }

  @override
  void dispose() {
    super.dispose();
    _categorySubject.close();
  }
}
