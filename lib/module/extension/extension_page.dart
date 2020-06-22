import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/extension_service.dart';
import 'package:comicappflutter/data/repo/extension_repo.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class ExtensionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Mở Rộng',
      isCenterTitle: true,
      bloc: [],
      di: [
        Provider.value(
          value: ExtensionService(),
        ),
        ProxyProvider<ExtensionService, ExtensionRepo>(
          update: (context, extensionService, _) =>
              ExtensionRepo(extensionService: extensionService),
        )
      ],
      child: ExtensionListWidget(),
    );
  }
}

class ExtensionListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              AppColor.green,
              Colors.green,
            ]),
      ),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white60, width: 2.0),
                ),
                padding: EdgeInsets.all(6.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://bloganchoi.com/wp-content/uploads/2017/03/naruto-uzumaki.jpg',
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Pham Trung Son',
            textAlign: TextAlign.center,
            style: TvStyle.fontAppWithCustom(
                size: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}

class ExtensionListItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool hasNavigation;

  ExtensionListItem({this.iconData, this.text, this.hasNavigation = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ).copyWith(bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.iconData,
            size: 10,
          ),
          SizedBox(width: 5),
          Text(
            this.text,
            style: TvStyle.fontAppWithCustom(),
          ),
          Spacer(),

          Icon(
            LineAwesomeIcons.angle_right,
            size: 10,
          ),
        ],
      ),
    );
  }
}
