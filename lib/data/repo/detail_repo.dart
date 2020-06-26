import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class DetailRepo {
  DetailService _detailService;

  DetailRepo({@required DetailService detailService})
      : _detailService = detailService;

  Future<List<Chapter>> getChaptersList(int idComic) async{
    var c = Completer<List<Chapter>>();
    try {
      var response = await _detailService.getChaptersList(idComic);
      var chapterList = Chapter.parseChaptersList(response.data);
      c.complete(chapterList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
