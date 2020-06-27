import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class HighlightService {
  Future<Response> getNominateComicList(String nextCursor) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/stories/nominate',
      queryParameters: {
        'next_cursor': nextCursor,
      },
    );
  }

  Future<Response> getNewUpdateComicList(String nextCursor) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/stories/time_fix',
      queryParameters: {
        'next_cursor': nextCursor,
      },
    );
  }

  Future<Response> getNewCreatedComicList(String nextCursor) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/stories/new_create',
      queryParameters: {
        'next_cursor': nextCursor,
      },
    );
  }

  Future<Response> getFinishedComicList(String nextCursor) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/stories/finish',
      queryParameters: {
        'next_cursor': nextCursor,
      },
    );
  }

  Future<Response> getTopViewComicList(String nextCursor) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/stories/top_month',
      queryParameters: {
        'next_cursor': nextCursor,
      },
    );
  }
}
