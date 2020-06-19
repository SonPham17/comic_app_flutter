import 'dart:async';

import 'package:comicappflutter/data/remote/category_service.dart';
import 'package:comicappflutter/shared/model/category.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class CategoryRepo {
  CategoryService _categoryService;

  CategoryRepo({@required CategoryService categoryService})
      : _categoryService = categoryService;

  Future<List<Category>> getCategory() async {
    var c = Completer<List<Category>>();
    try {
      var response = await _categoryService.getCategory();
      var categoryList = Category.parseCategoryList(response.data);
      c.complete(categoryList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
