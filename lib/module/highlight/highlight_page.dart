import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/highlight_service.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:comicappflutter/module/highlight/highlight_bloc.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HighlightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Novel Galaxy',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('search');
          },
        )
      ],
      isCenterTitle: true,
      di: [
        Provider.value(
          value: HighlightService(),
        ),
        ProxyProvider<HighlightService, HighlightRepo>(
          update: (context, highlightService, previous) =>
              HighlightRepo(highlightService: highlightService),
        ),
      ],
      bloc: [],
      child: ComicListWidget(),
    );
  }
}

class ComicListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HighlightBloc.getInstance(
        highlightRepo: Provider.of(context),
      ),
      child: Consumer<HighlightBloc>(
        builder: (context, bloc, child) => Container(),
      ),
    );
  }
}
