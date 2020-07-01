import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class SearchService{
  Future<Response> searchByAuthorComicList(String query) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/story/search',
      queryParameters: {
        'author': query,
      },
    );
  }

  Future<Response> searchByNameComicList(String query) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/story/search',
      queryParameters: {
        'story': query,
      },
    );
  }
}