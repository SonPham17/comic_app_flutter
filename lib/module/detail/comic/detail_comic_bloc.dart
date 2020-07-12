import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/module/detail/comic/like_comic_event.dart';
import 'package:comicappflutter/module/detail/comic/update_comic_event.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DetailComicBloc extends BaseBloc {
  DetailRepo _detailRepo;

  StreamController<List<List<Chapter>>> _chaptersSubject =
      BehaviorSubject<List<List<Chapter>>>();

  Stream<List<List<Chapter>>> get chaptersStream => _chaptersSubject.stream;

  Sink<List<List<Chapter>>> get chaptersSink => _chaptersSubject.sink;

  StreamController<bool> _likeSubject = BehaviorSubject<bool>();

  Stream<bool> get likeStream => _likeSubject.stream;

  Sink<bool> get likeSink => _likeSubject.sink;

  bool _isLiked;
  bool get isLiked => _isLiked;

  DetailComicBloc({DetailRepo detailRepo}) : _detailRepo = detailRepo;

  void getChaptersList(int idComic) {
    _detailRepo.getChaptersList(idComic).then((value) {
      if (!_likeSubject.isClosed) {
        chaptersSink.add(value);
      }
    });
  }

  @override
  void dispatchEvent(BaseEvent baseEvent) async {
    switch (baseEvent.runtimeType) {
      case LikeComicEvent:
        LikeComicEvent likeComicEvent = baseEvent as LikeComicEvent;
        if (_isLiked) {
          await _detailRepo.deleteLikeComic(likeComicEvent.comic).then((value) {
            _isLiked = false;
          });
        } else {
          await _detailRepo.insertLikeComic(likeComicEvent.comic).then((value) {
            _isLiked = true;
          });
        }
        break;
    }
  }

  void checkComicIsLiked(int idComic){
    _detailRepo.findComicFollowInDB(idComic).then((comic) {
      if (comic != null) {
        likeSink.add(true);
        print('comic khac null');
        _isLiked = true;
      } else {
        likeSink.add(false);
        print('comic bang null');
        _isLiked = false;
      }
    });
    print('comic check');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose bloc');
    _chaptersSubject.close();
    _likeSubject.close();
  }
}
