import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class HighlightService {
  Future<Response> getNominateComicList() {
    return ComicClient.instance.dio
        .get('/hello_novel/public/api/stories/nominate');
  }
}
