import 'dart:async';
import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/detail_repo.dart';
import 'package:comicappflutter/db/model/chapter.dart';
import 'package:comicappflutter/module/detail/chapter/download_comic_event.dart';
import 'package:comicappflutter/module/detail/chapter/download_finish_comic_event.dart';
import 'package:rxdart/rxdart.dart';

class DetailChapterBloc extends BaseBloc {
  DetailRepo _detailRepo;

  String _content;

  DetailChapterBloc({DetailRepo detailRepo}) : _detailRepo = detailRepo;

  StreamController<String> _contentSubject = BehaviorSubject<String>();
  Stream<String> get contentStream => _contentSubject.stream;
  Sink<String> get contentSink => _contentSubject.sink;

  StreamController<bool> _chapterIsExistSubject = BehaviorSubject<bool>();
  Stream<bool> get chapterIsExistStream => _chapterIsExistSubject.stream;
  Sink<bool> get chapterIsExistSink => _chapterIsExistSubject.sink;

  void getContentChapter(int id) async {
    print(id);
    await _detailRepo.getContentChapter(id).then((value) {
      if (!_contentSubject.isClosed) {
        _content = value;
        contentSink.add(value);
        if (value.isEmpty) {
          chapterIsExistSink.add(true);
        } else {
          _detailRepo.findComicChapterInDB(id).then((value) {
            if (!_contentSubject.isClosed) {
              if (value) {
                chapterIsExistSink.add(true);
              } else {
                chapterIsExistSink.add(false);
              }
            }
          });
        }
      }
    });
  }

  @override
  void dispatchEvent(BaseEvent baseEvent) async {
    switch (baseEvent.runtimeType) {
      case DownloadComicEvent:
        DownloadComicEvent downloadComicEvent = baseEvent as DownloadComicEvent;
        var comic = downloadComicEvent.comic;
        await _detailRepo.insertDownloadComic(comic);
        var chapter = downloadComicEvent.chapter;
        _detailRepo
            .insertDownloadChapter(ChapterComic(
          idChapter: chapter.id,
          idComic: comic.id,
          nameIdChapter: chapter.nameIdChapter,
          contentTitleOfChapter: chapter.contentTitleOfChapter,
          createdAt: chapter.createdAt,
          updatedAt: chapter.updatedAt,
          vol: chapter.vol,
          content: _content,
        ))
            .then((value) {
          if (value) {
            processEventSink
                .add(DownloadFinishComicEvent(msg: 'Tải xuống thành công!'));
            chapterIsExistSink.add(true);
          } else {
            processEventSink
                .add(DownloadFinishComicEvent(msg: 'Tải xuống thất bại!'));
            chapterIsExistSink.add(false);
          }
        });
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _contentSubject.close();
    _chapterIsExistSubject.close();
  }
}
