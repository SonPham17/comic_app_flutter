import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class HighlightService {
  Future<Response> getNominateComicList() {
    return ComicClient.instance.dio
        .get('/hello_novel/public/api/stories/nominate');
  }

  Future<Response> getNewUpdateComicList() {
    return ComicClient.instance.dio
        .get('/hello_novel/public/api/stories/time_fix');
  }

  Future<Response> getNewCreatedComicList() {
    return ComicClient.instance.dio
        .get('/hello_novel/public/api/stories/new_create');
  }

  Future<Response> getFinishedComicList() {
    return ComicClient.instance.dio
        .get('/hello_novel/public/api/stories/finish');
  }

  Future<Response> getTopViewComicList() {
    return ComicClient.instance.dio
        .get('/hello_novel/public/api/stories/top_month');
  }
}
