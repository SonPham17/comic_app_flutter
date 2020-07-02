import 'package:animations/animations.dart';
import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/category_service.dart';
import 'package:comicappflutter/data/repo/category_repo.dart';
import 'package:comicappflutter/module/category/detail/detail_category_bloc.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_page.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/open_container_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_category_load_more_event.dart';

class DetailCategoryPage extends StatefulWidget {
  @override
  _DetailCategoryPageState createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  var _args;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _args = ModalRoute.of(context).settings.arguments as Map;
    print(_args['id']);
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: _args['title'],
      bloc: [],
      di: [
        Provider.value(
          value: CategoryService(),
        ),
        ProxyProvider<CategoryService, CategoryRepo>(
          update: (context, categoryService, _) =>
              CategoryRepo(categoryService: categoryService),
        ),
      ],
      child: DetailCategoryGridWidget(
        id: _args['id'],
      ),
    );
  }
}

class DetailCategoryGridWidget extends StatefulWidget {
  final int _id;

  DetailCategoryGridWidget({@required int id}) : _id = id;

  @override
  _DetailCategoryGridWidgetState createState() =>
      _DetailCategoryGridWidgetState();
}

class _DetailCategoryGridWidgetState extends State<DetailCategoryGridWidget> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final ScrollController _controller = ScrollController();
  static const double _endReachedThreshold =
      100; // cách bottom 200px thì loadmore

  List<Comic> _listDataComic = List<Comic>();

  bool _loading = true;
  bool _canLoadMore = true;

  void setupStreamAndController(DetailCategoryBloc bloc) {
    bloc.event.add(DetailCategoryLoadMoreEvent(id: widget._id));

    _controller.addListener(() {
      if (!_controller.hasClients || _loading) return;

      final thresholdReached =
          _controller.position.extentAfter < _endReachedThreshold;

      if (thresholdReached) {
        _loading = true;
        bloc.event.add(DetailCategoryLoadMoreEvent(id: widget._id));
      }
    });
  }

  Future<void> _refresh() async {
    _canLoadMore = true;
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => DetailCategoryBloc(
        categoryRepo: Provider.of(context),
      ),
      child: Consumer<DetailCategoryBloc>(builder: (context, bloc, child) {
        setupStreamAndController(bloc);
        return StreamProvider<Object>.value(
          value: bloc.detailCategoryStream,
          initialData: null,
          child: Consumer<Object>(
            builder: (context, data, child) {
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

              var result = data as Map;
              var nextCursor = result['next_cursor'];
              if (nextCursor == null) {
                _loading = true;
                _canLoadMore = false;
              } else {
                _loading = false;
                _canLoadMore = true;
              }
              _listDataComic.addAll(Comic.parseComicList(result));

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
                        mainAxisSpacing: 5,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (_, index) => OpenContainerWrapper(
                          margin: EdgeInsets.all(1),
                          transitionType: _transitionType,
                          closedBuilder:
                              (BuildContext _, VoidCallback openContainer) {
                            return InkWell(
                              onTap: openContainer,
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                      'https://www.nae.vn/ttv/ttv/public/images/story/${_listDataComic[index].image}.jpg',
                                      height: 180,
                                      fit: BoxFit.cover),
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
                            );
                          },
                          child: DetailComicPage(
                            comic: _listDataComic[index],
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
        );
      }),
    );
  }
}
