import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:flutter/widgets.dart';

class DetailComicBloc extends BaseBloc {
  DetailRepo _detailRepo;

  static DetailComicBloc _instance;

  static DetailComicBloc getInstance({@required DetailRepo detailRepo}) {
    if (_instance == null) {
      _instance = DetailComicBloc._internal(detailRepo: detailRepo);
    }
    return _instance;
  }

  DetailComicBloc._internal({@required DetailRepo detailRepo})
      : _detailRepo=detailRepo;



  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }

}