import 'package:comicappflutter/data/remote/search_service.dart';
import 'package:flutter/widgets.dart';

class SearchRepo {
  SearchService _searchService;

  SearchRepo({@required SearchService searchService})
      : _searchService = searchService;


}
