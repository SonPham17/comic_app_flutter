import 'package:comicappflutter/module/bookcase/bookcase_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/item_grid_comic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookcaseHistoryPage extends StatefulWidget {
  final BookcaseBloc bloc;

  BookcaseHistoryPage({this.bloc});

  @override
  _BookcaseHistoryPageState createState() => _BookcaseHistoryPageState();
}

class _BookcaseHistoryPageState extends State<BookcaseHistoryPage> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.bloc.getListComicHistoryInDB();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Comic>>.value(
      value: widget.bloc.bookcaseHistoryStream,
      initialData: null,
      child: Consumer<List<Comic>>(
        builder: (_, data, child) {
          if (data == null) {
            return Container(
              height: 170,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.green),
                ),
              ),
            );
          }

          if (data.length == 0) {
            return Container(
              child: Center(
                child: Text(
                  'Chưa có bộ truyện nào trong mục này',
                  style: TvStyle.fontAppWithCustom(),
                ),
              ),
            );
          }

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
                childAspectRatio: 0.55,
                children: data
                    .map((comic) => ItemGridComic(
                  isOpenDownload: false,
                  comic: comic,
                  funcClose: (isClose){
                    widget.bloc.getListComicHistoryInDB();
                  },
                ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
