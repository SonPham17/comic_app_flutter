import 'dart:async';
import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class DetailService {
  Future<Response> getChaptersList(int storyId) {
    return ComicClient.instance.dio.get(
      '/hello_novel/public/api/story/infor',
      queryParameters: {
        'story_id': storyId,
      },
    );
  }
}
