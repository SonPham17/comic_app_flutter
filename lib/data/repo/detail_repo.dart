import 'dart:isolate';

import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:comicappflutter/shared/model/chapter.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class DetailRepo {
  DetailService _detailService;

  DetailRepo({@required DetailService detailService})
      : _detailService = detailService;

  Future<List<List<Chapter>>> getChaptersList(int idComic) async{
    var c = Completer<List<List<Chapter>>>();
    try {
      var response = await _detailService.getChaptersList(idComic);
      var chapterNew = response.data['story']['chapter_new'];
      if(chapterNew !=null){
        var result = await compute(taskRunner,response.data);
        c.complete(result);
      }else{
        print('ko co vol');
        c.complete(List<List<Chapter>>());
      }
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  static List<List<Chapter>> taskRunner(dynamic data){
    var totalVol = data['story']['chapter_new']['vol'];
    var chapters = Chapter.parseChaptersList(data);
    var listChapters = List<List<Chapter>>();
    for (int i = 1; i <= totalVol; i++) {
      var listChaptersByVol = List<Chapter>();
      for(int j=0;j<chapters.length;j++){
        if(chapters[j].vol == i){
          listChaptersByVol.add(chapters[j]);
        }
      }
      listChapters.add(listChaptersByVol);
    }
    return listChapters;
  }
}
