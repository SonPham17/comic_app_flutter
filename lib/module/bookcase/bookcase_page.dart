import 'package:comicappflutter/data/remote/bookcase_service.dart';
import 'package:comicappflutter/data/repo/bookcase_repo.dart';
import 'package:comicappflutter/module/bookcase/bookcase_bloc.dart';
import 'package:comicappflutter/module/bookcase/tab_view/bookcase_download_page.dart';
import 'package:comicappflutter/module/bookcase/tab_view/bookcase_history_page.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab_view/bookcase_follow_page.dart';

class BookcasePage extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: BookcaseService(),
        ),
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
          body: Provider(
            create: (context) => BookcaseBloc(
              bookcaseRepo: Provider.of(context, listen: false),
            ),
            child: Consumer<BookcaseBloc>(
              builder: (_, bloc, child) => TabBarView(
                children: [
                  BookcaseHistoryPage(
                    bloc: bloc,
                  ),
                  BookcaseFollowPage(
                    bloc: bloc,
                  ),
                  BookcaseDownloadPage(
                    bloc: bloc,
                  ),
                ],
              ),
            ),
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
