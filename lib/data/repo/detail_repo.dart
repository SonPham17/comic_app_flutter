import 'package:comicappflutter/data/remote/detail_service.dart';
import 'package:flutter/widgets.dart';

class DetailRepo {
  DetailService _detailService;

  DetailRepo({@required DetailService detailService})
      : _detailService = detailService;


}
