import 'package:comicappflutter/data/remote/highlight_service.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class HighlightRepo {
  HighlightService _highlightService;

  HighlightRepo({@required HighlightService highlightService})
      : _highlightService = highlightService;

  Future<dynamic> getNominateComicList() async {
    var c = Completer<dynamic>();
    try {
      var response = await _highlightService.getNominateComicList('');
//      var nominateList = Comic.parseComicList(response.data);
      c.complete(response.data);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<dynamic> getNewUpdateComicList(String nextCursor) async {
    var c = Completer<dynamic>();
    try {
      var response = await _highlightService.getNewUpdateComicList(nextCursor);
//      var nominateList = Comic.parseComicList(response.data);
      c.complete(response.data);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<dynamic> getNewCreatedComicList(String nextCursor) async {
    var c = Completer<dynamic>();
    try {
      var response = await _highlightService.getNewCreatedComicList(nextCursor);
//      var nominateList = Comic.parseComicList(response.data);
      c.complete(response.data);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<dynamic> getFinishedComicList(String nextCursor) async {
    var c = Completer<dynamic>();
    try {
      var response = await _highlightService.getFinishedComicList(nextCursor);
//      var nominateList = Comic.parseComicList(response.data);
      c.complete(response.data);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<dynamic> getTopViewComicList(String nextCursor) async {
    var c = Completer<dynamic>();
    try {
      var response = await _highlightService.getTopViewComicList(nextCursor);
//      var nominateList = Comic.parseComicList(response.data);
      c.complete(response.data);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }
}
