import 'package:comicappflutter/module/bookcase/bookcase_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/comic.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:comicappflutter/shared/widget/item_grid_comic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookcaseDownloadPage extends StatefulWidget {
  final BookcaseBloc bloc;

  BookcaseDownloadPage({this.bloc});

  @override
  _BookcaseDownloadPageState createState() => _BookcaseDownloadPageState();
}

class _BookcaseDownloadPageState extends State<BookcaseDownloadPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.bloc.getListComicDownloadInDB();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Comic>>.value(
      value: widget.bloc.bookcaseDownloadStream,
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
                childAspectRatio: 0.5,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: data
                    .map((comic) => ItemGridComic(
                  isOpenDownload: true,
                  comic: comic,
                  funcClose: (isClose){
                    widget.bloc.getListComicDownloadInDB();
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
