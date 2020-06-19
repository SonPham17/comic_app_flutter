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

  Future<List<Comic>> getNominateComicList() async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _highlightService.getNominateComicList();
      var nominateList = Comic.parseComicList(response.data);
      c.complete(nominateList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<List<Comic>> getNewUpdateComicList() async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _highlightService.getNewUpdateComicList();
      var nominateList = Comic.parseComicList(response.data);
      c.complete(nominateList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<List<Comic>> getNewCreatedComicList() async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _highlightService.getNewCreatedComicList();
      var nominateList = Comic.parseComicList(response.data);
      c.complete(nominateList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<List<Comic>> getFinishedComicList() async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _highlightService.getFinishedComicList();
      var nominateList = Comic.parseComicList(response.data);
      c.complete(nominateList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<List<Comic>> getTopViewComicList() async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _highlightService.getTopViewComicList();
      var nominateList = Comic.parseComicList(response.data);
      c.complete(nominateList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }
}
