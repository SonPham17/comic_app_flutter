import 'package:comicappflutter/data/remote/highlight_service.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class HighlightRepo {
  HighlightService _highlightService;

  HighlightRepo({@required HighlightService highlightService})
      : _highlightService = highlightService;

  Future<List<Comic>> getNominateComicList() async {
    var c = Completer<List<Comic>>();
    try {
      var response = await _highlightService.getNominateComicList();
      var nominateList = Comic.parseComicList(response.data);
      c.complete(nominateList);
    } catch (e) {
      c.completeError(e);
    }

    return c.future;
  }
}
