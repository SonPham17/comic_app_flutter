import 'package:comicappflutter/data/remote/search_service.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class SearchRepo {
  SearchService _searchService;

  SearchRepo({@required SearchService searchService})
      : _searchService = searchService;

  Future<List<Comic>> searchByAuthorComicList(String query) async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _searchService.searchByAuthorComicList(query);
      var searchList = Comic.parseComicListBySearch(response.data);
      c.complete(searchList);
    } on DioError {
      print('dio error');
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }

  Future<List<Comic>> searchByNameComicList(String query) async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _searchService.searchByNameComicList(query);
      var searchList = Comic.parseComicListBySearch(response.data);
      c.complete(searchList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }
}
