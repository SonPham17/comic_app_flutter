import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/highlight_service.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:comicappflutter/module/highlight/highlight_bloc.dart';
import 'package:comicappflutter/module/highlight/load_more/event/load_more_event.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadMorePage extends StatefulWidget {
  @override
  _LoadMorePageState createState() => _LoadMorePageState();
}

class _LoadMorePageState extends State<LoadMorePage> {
  var _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _args = ModalRoute.of(context).settings.arguments as Map;
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: _args['title'],
      bloc: [],
      di: [
        Provider.value(
          value: HighlightService(),
        ),
        ProxyProvider<HighlightService, HighlightRepo>(
          update: (context, highlightService, previous) =>
              HighlightRepo(highlightService: highlightService),
        ),
      ],
      child: LoadMoreGridWidget(
        type: _args['type'],
      ),
    );
  }
}

class LoadMoreGridWidget extends StatefulWidget {
  final int type;

  LoadMoreGridWidget({Key key, this.type}) : super(key: key);

  @override
  _LoadMoreGridWidgetState createState() => _LoadMoreGridWidgetState();
}

class _LoadMoreGridWidgetState extends State<LoadMoreGridWidget> {
  Stream<Object> _stream;
  static const double _endReachedThreshold =
      100; // cách bottom 200px thì loadmore

  final ScrollController _controller = ScrollController();

  List<Comic> _listDataComic = List<Comic>();

  bool _loading = true;
  bool _canLoadMore = true;

  Future<void> _refresh() async {
    _canLoadMore = true;
  }

  void setupStreamAndController(HighlightBloc bloc) {
    switch (widget.type) {
      case 1:
        _stream = bloc.topViewComicStream;
        break;
      case 2:
        _stream = bloc.newUpdateComicStream;
        break;
      case 3:
        _stream = bloc.newCreatedComicStream;
        break;
      case 4:
        _stream = bloc.finishedComicStream;
        break;
    }
    bloc.event.add(LoadMoreEvent(type: widget.type));

    _controller.addListener(() {
      if (!_controller.hasClients || _loading) return;

      final thresholdReached =
          _controller.position.extentAfter < _endReachedThreshold;

      if (thresholdReached) {
        _loading = true;
        bloc.event.add(LoadMoreEvent(type: widget.type));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => HighlightBloc(
        highlightRepo: Provider.of(context),
      ),
      child: Consumer<HighlightBloc>(builder: (context, bloc, child) {
        setupStreamAndController(bloc);
        return Container(
          child: StreamProvider<Object>.value(
            value: _stream,
            initialData: null,
            child: Consumer<Object>(
              builder: (_, data, child) {
                if (data == null) {
                  return Container(
                    height: 170,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColor.green,
                      ),
                    ),
                  );
                }

                if (data is RestError) {
                  return Center(
                    child: Container(
                      child: Text(
                        data.message,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }

                var mapData = data as Map;
                var comicList = Comic.parseComicList(mapData);
                _listDataComic.addAll(comicList);
                _loading = false;

                return CustomScrollView(
                  controller: _controller,
                  slivers: <Widget>[
                    CupertinoSliverRefreshControl(
                      onRefresh: _refresh,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(5),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.5,
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => Container(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/detail/comic_page',
                                        arguments: _listDataComic[index]);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                        'https://www.nae.vn/ttv/ttv/public/images/story/${_listDataComic[index].image}.jpg',
                                        height: 180,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                    _listDataComic[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TvStyle.fontAppWithSize(12),
                                    textAlign: TextAlign.center,
                                  )),
                                )
                              ],
                            ),
                          ),
                          childCount: _listDataComic.length,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _canLoadMore
                          ? Container(
                              padding: EdgeInsets.only(bottom: 16),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(),
                    )
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
