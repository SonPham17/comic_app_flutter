import 'package:comicappflutter/data/remote/search_service.dart';
import 'package:comicappflutter/data/repo/search_repo.dart';
import 'package:comicappflutter/module/search/search_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/custom_appbar.dart';
import 'package:comicappflutter/shared/widget/item_grid_comic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TypeSearch { tacgia, tentruyen }

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return MultiProvider(
      providers: [
        Provider.value(
          value: SearchService(),
        ),
        ProxyProvider<SearchService, SearchRepo>(
          update: (context, searchService, _) =>
              SearchRepo(searchService: searchService),
        )
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          height: 92,
          child: Provider(
              create: (_) => SearchBloc.getInstance(
                    searchRepo: Provider.of(context),
                  ),
              child: Consumer<SearchBloc>(
                builder: (context, bloc, child) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: statusBarHeight + 6, bottom: 6, left: 5, right: 5),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          child: Icon(Icons.keyboard_backspace),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.green,
                                  style: TvStyle.fontAppWithCustom(size: 14),
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.search),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Nhập từ khóa để tìm kiếm',
                                      hintStyle:
                                          TvStyle.fontAppWithCustom(size: 14)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            var query = searchController.text;
                            if (query.isEmpty) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Nội dung quá ngắn để tìm kiếm',
                                  style: TvStyle.fontAppWithCustom(),
                                ),
                                backgroundColor: Colors.red,
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            'Tìm kiếm',
                            style: TvStyle.fontAppWithCustom(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
        body: SearchListWidget(),
      ),
    );
  }
}

class SearchListWidget extends StatefulWidget {
  @override
  _SearchListWidgetState createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  TypeSearch _type = TypeSearch.tacgia;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SearchBloc.getInstance(
        searchRepo: Provider.of(context),
      ),
      child: Consumer<SearchBloc>(
        builder: (context, bloc, child) => Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Theo tên tác giả',
                  style: TvStyle.fontAppWithCustom(),
                ),
                leading: Radio(
                  value: TypeSearch.tacgia,
                  groupValue: _type,
                  onChanged: (value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  'Theo tên truyện',
                  style: TvStyle.fontAppWithCustom(),
                ),
                leading: Radio(
                  value: TypeSearch.tentruyen,
                  groupValue: _type,
                  onChanged: (value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamProvider<List<Comic>>.value(
                  value: bloc.searchStream,
                  initialData: [],
                  child: Consumer<List<Comic>>(
                    builder: (context, data, child) {
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

                      var listDataSearch = data;
                      return Container(
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
                            children: listDataSearch
                                .map((comic) => ItemGridComic(
                                      comic: comic,
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
