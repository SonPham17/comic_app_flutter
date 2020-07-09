import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/bookcase_repo.dart';
import 'package:comicappflutter/module/detail/comic/update_comic_event.dart';
import 'package:flutter/widgets.dart';

class BookcaseBloc extends BaseBloc {
  BookcaseRepo _bookcaseRepo;

  BookcaseBloc({@required BookcaseRepo bookcaseRepo}) : _bookcaseRepo = bookcaseRepo;

  @override
  void dispatchEvent(BaseEvent baseEvent) {
    switch(baseEvent.runtimeType){
      case UpdateComicEvent:
        print('update bookcase');
        break;
    }
  }
}
