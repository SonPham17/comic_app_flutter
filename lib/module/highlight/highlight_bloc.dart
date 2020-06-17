import 'package:comicappflutter/base/base_bloc.dart';
import 'package:comicappflutter/base/base_event.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:flutter/widgets.dart';

class HighlightBloc extends BaseBloc with ChangeNotifier {
  HighlightRepo _highlightRepo;

  static HighlightBloc _instance;

  static HighlightBloc getInstance({@required HighlightRepo highlightRepo}) {
    if (_instance == null) {
      _instance = HighlightBloc._internal(highlightRepo: highlightRepo);
    }
    return _instance;
  }

  HighlightBloc._internal({@required HighlightRepo highlightRepo})
      : _highlightRepo = highlightRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    print(event);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
