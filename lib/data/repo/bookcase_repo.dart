import 'package:comicappflutter/data/remote/bookcase_service.dart';
import 'package:flutter/widgets.dart';

class BookcaseRepo {
  BookcaseService _bookcaseService;

  BookcaseRepo({@required BookcaseService bookcaseService})
      : _bookcaseService = bookcaseService;
}
