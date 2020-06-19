import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/bookcase_service.dart';
import 'package:comicappflutter/data/repo/bookcase_repo.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookcasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Tủ Sách',
      isCenterTitle: true,
      tabBar: TabBar(
        isScrollable: true,
        tabs: listTab
            .map((item) => Tab(
                  text: item.title,
                  icon: Icon(item.iconData),
                ))
            .toList(),
      ),
      di: [
        Provider.value(
          value: BookcaseService(),
        ),
        ProxyProvider<BookcaseService, BookcaseRepo>(
          update: (context, bookcaseService, _) =>
              BookcaseRepo(bookcaseService: bookcaseService),
        ),
      ],
      bloc: [],
      child: TabBarView(
        children: listTab
            .map((item) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(item.title),
                ))
            .toList(),
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
