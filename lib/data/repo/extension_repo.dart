import 'package:comicappflutter/data/remote/extension_service.dart';
import 'package:flutter/widgets.dart';

class ExtensionRepo {
  ExtensionService _extensionService;

  ExtensionRepo({@required ExtensionService extensionService})
      : _extensionService = extensionService;
}
