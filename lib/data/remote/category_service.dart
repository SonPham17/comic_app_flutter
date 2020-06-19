import 'dart:async';
import 'package:comicappflutter/network/comic_client.dart';
import 'package:dio/dio.dart';

class CategoryService{
  Future<Response> getCategory(){
    return ComicClient.instance.dio.get('/hello_novel/public/api/categories');
  }
}