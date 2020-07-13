import 'package:animations/animations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/container_transition.dart';
import 'package:comicappflutter/data/remote/highlight_service.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:comicappflutter/module/detail/comic/detail_comic_page.dart';
import 'package:comicappflutter/module/highlight/highlight_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/item_grid_comic.dart';
import 'package:comicappflutter/shared/widget/open_container_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HighlightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      leading: IconButton(
        icon: Icon(Icons.free_breakfast),
        onPressed: () {
          Navigator.pushNamed(context, '/detail/chapter_page');
        },
      ),
      title: 'Novel Galaxy',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
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
      child: HighlightListWidget(),
    );
  }
}

class HighlightListWidget extends StatelessWidget {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => HighlightBloc(
        highlightRepo: Provider.of(context),
      ),
      child: Consumer<HighlightBloc>(
        builder: (context, bloc, child) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildNominateComic(bloc, context),
              ItemComicListPage(
                type: 1,
                title: 'Xem Nhiều Trong Tháng',
                stream: bloc.topViewComicStream,
                loadApi: bloc.getTopViewComicList,
              ),
              ItemComicListPage(
                type: 2,
                title: 'Mới Cập Nhật',
                stream: bloc.newUpdateComicStream,
                loadApi: bloc.getNewUpdateComicList,
              ),
              ItemComicListPage(
                type: 3,
                title: 'Mới Tạo',
                stream: bloc.newCreatedComicStream,
                loadApi: bloc.getNewCreatedComicList,
              ),
              ItemComicListPage(
                type: 4,
                title: 'Đã Hoàn Thành',
                stream: bloc.finishedComicStream,
                loadApi: bloc.getFinishedComicList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNominateComic(HighlightBloc bloc, BuildContext context) {
    bloc.getNominateComicList();
    return Container(
      child: StreamProvider<Object>.value(
        value: bloc.nominateComicStream,
        initialData: null,
        catchError: (context, error) {
          return error;
        },
        child: Consumer<Object>(
          builder: (_, data, child) {
            if (data == null) {
              return Container(
                height: 170,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.blue,
                  ),
                ),
              );
            }

            data = Comic.parseComicList(data);
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

            var nominateList = data as List<Comic>;
            return Container(
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                    items: setupCarouseList(nominateList, context),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> setupCarouseList(List<Comic> comis, BuildContext context) {
    return comis
        .map((item) => OpenContainerWrapper(
              margin: EdgeInsets.all(5),
              child: DetailComicPage(
                comic: item,
                isOpenDownload: false,
              ),
              transitionType: _transitionType,
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return Container(
                  child: GestureDetector(
                    onTap: openContainer,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                                'https://www.nae.vn/ttv/ttv/public/images/story/${item.image}.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  item.name,
                                  style: TvStyle.fontAppWithCustom(
                                      color: Colors.white,
                                      size: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ))
        .toList();
  }
}

class ItemComicListPage extends StatefulWidget {
  final String _title;
  final Function _loadApi;
  final Stream<Object> _stream;
  final int _type;

  ItemComicListPage(
      {@required String title,
      @required Function loadApi,
      @required Stream<Object> stream,
      @required int type})
      : _title = title,
        _stream = stream,
        _loadApi = loadApi,
        _type = type;

  @override
  _ItemComicListPageState createState() => _ItemComicListPageState();
}

class _ItemComicListPageState extends State<ItemComicListPage> {
  @override
  void initState() {
    super.initState();
    print('_loadApi');
    widget._loadApi();
  }

  @override
  Widget build(BuildContext context) {
    return _baseBuildWidgetComic(
        stream: widget._stream, title: widget._title, type: widget._type);
  }

  Widget _baseBuildWidgetComic(
      {Stream<Object> stream, String title, int type}) {
    return StreamProvider<Object>.value(
      value: stream,
      initialData: null,
      catchError: (context, error) {
        print('Không thể tải mới dữ liệu');
        BotToast.showText(text: 'Không thể tải mới dữ liệu');
        return error;
      },
      child: Consumer<Object>(builder: (_, data, child) {
        if (data == null) {
          return Container(
            height: 170,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.blue,
              ),
            ),
          );
        }

        if (data is RestError) {
          BotToast.showText(text: 'Không thể tải mới dữ liệu');
        }

        var mapData = data as Map;
        var newUpdateList = Comic.parseComicList(mapData);
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(title,
                      style: TvStyle.fontAppWithCustom(
                          size: 20.0,
                          color: AppColor.green,
                          fontWeight: FontWeight.bold)),
                  margin: EdgeInsets.only(top: 5, left: 5),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/load_more',
                        arguments: {'title': title, 'type': type});
                  },
                  child: Container(
                    child: Text('Xem Thêm',
                        style: TvStyle.fontAppWithCustom(
                            size: 18.0,
                            color: AppColor.green,
                            textDecoration: TextDecoration.underline)),
                    margin: EdgeInsets.only(right: 5),
                  ),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  // số lượng cột trong 1 hàng
                  mainAxisSpacing: 5,
                  // khoảng cách giữa các thằng con theo trục dọc
                  crossAxisSpacing: 5,
                  // khoảng cách giữa các cột theo trục ngang
                  padding: EdgeInsets.all(5),
                  childAspectRatio: 0.5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: newUpdateList
                      .map((comic) => ItemGridComic(
                            comic: comic,
                    isOpenDownload: false,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
