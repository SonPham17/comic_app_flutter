import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/highlight_service.dart';
import 'package:comicappflutter/data/repo/highlight_repo.dart';
import 'package:comicappflutter/module/highlight/highlight_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/model/rest_error.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    return Provider(
      create: (_) => HighlightBloc.getInstance(
        highlightRepo: Provider.of(context),
      ),
      child: Consumer<HighlightBloc>(
        builder: (context, bloc, child) => ListView(
          children: <Widget>[
            _buildNominateComic(bloc),
            _buildNewUpdateComic(bloc),
          ],
        ),
      ),
    );
  }

  _buildNewUpdateComic(HighlightBloc bloc) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text('Mới Cập Nhật', style: TvStyle.fontAppWithSize(18.0)),
              margin: EdgeInsets.only(top: 5, left: 5),
            ),
            Container(
              child: Text('Xem Thêm', style: TvStyle.fontAppWithSize(18.0)),
              margin: EdgeInsets.only(right: 5),
            ),
          ],
        ),
        Container(
          child: StreamProvider<List<Comic>>.value(
            value: bloc.getNewUpdateComicList(),
            initialData: null,
            catchError: (context, error) {
              return error;
            },
            child: Consumer<List<Comic>>(builder: (_, data, child) {
              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.blue,
                  ),
                );
              }

              var newUpdateList = data;
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 3, // số lượng cột trong 1 hàng
                    mainAxisSpacing: 8, // khoảng cách giữa các thằng con theo trục dọc
                    crossAxisSpacing: 8, // khoảng cách giữa các cột theo trục ngang
                    padding: EdgeInsets.all(8),
                    childAspectRatio: 0.5,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: newUpdateList
                        .map((comic) => _buildItemGrid(comic))
                        .toList(),
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  _buildNominateComic(HighlightBloc bloc) {
    return Container(
      child: StreamProvider<Object>.value(
        value: bloc.getNominateComicList(),
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
                        enlargeCenterPage: true),
                    items: setupCarouseList(nominateList),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemGrid(Comic comic) {
    Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        'https://www.nae.vn/ttv/ttv/public/images/story/${comic.image}.jpg',
        fit: BoxFit.cover,
      ),
    );

    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(comic.name),
          subtitle: Text(comic.author),
        ),
      ),
      child: image,
    );
  }

  List<Widget> setupCarouseList(List<Comic> comis) {
    return comis
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                            'https://www.nae.vn/ttv/ttv/public/images/story/${item.image}.jpg',
                            fit: BoxFit.cover,
                            width: 1000.0),
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
            ))
        .toList();
  }
}
