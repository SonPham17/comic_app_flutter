import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/bookcase_service.dart';
import 'package:comicappflutter/data/repo/bookcase_repo.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabbar/tabbar.dart';

class BookcasePage extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: BookcaseService()),
        ProxyProvider<BookcaseService, BookcaseRepo>(
          update: (context, bookcaseService, _) =>
              BookcaseRepo(bookcaseService: bookcaseService),
        ),
      ],
      child: DefaultTabController(
        length: listTab.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.white,
              labelStyle: TvStyle.fontAppWithCustom(size: 10),
              tabs: listTab
                  .map((item) => Tab(
                        text: item.title,
                        icon: Icon(item.iconData),
                      ))
                  .toList(),
            ),
            centerTitle: true,
            title: Text(
              'Tủ Sách',
              style: TvStyle.fontApp(),
            ),
          ),
          body: TabBarView(
            children: listTab
                .map((item) => Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text(item.title)),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ItemTabBar {
  final String title;
  final IconData iconData;

  const ItemTabBar({this.title, this.iconData});
}

const List<ItemTabBar> listTab = [
  ItemTabBar(title: 'LỊCH SỬ', iconData: Icons.history),
  ItemTabBar(title: 'THEO DÕI', iconData: Icons.bookmark),
  ItemTabBar(title: 'TẢI VỀ', iconData: Icons.cloud_download),
];
