import 'dart:async';
import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class CategoryService {
  Future<Response> getCategory() {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/categories',
    );
  }

  Future<Response> getComicByCategory(int id, String nextCursor) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/category/$id/stories',
      queryParameters: {
        'next_cursor': nextCursor,
      },
    );
  }
}
