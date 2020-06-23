import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/extension_service.dart';
import 'package:comicappflutter/data/repo/extension_repo.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                  margin: EdgeInsets.only(top: 30),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white60, width: 2.0),
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/main_icon.png',
                      height: 120,
                      width: 120,
                    ),
                  )),
            ],
          ),
          Text(
            'Pham Trung Son',
            textAlign: TextAlign.center,
            style: TvStyle.fontAppWithCustom(
                size: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                ExtensionListItem(
                  iconData: LineAwesomeIcons.globe,
                  text: 'Chọn nguồn truyện',
                ),
                ExtensionListItem(
                  iconData: LineAwesomeIcons.star,
                  text: 'Đánh giá ứng dụng',
                ),
                ExtensionListItem(
                  iconData: LineAwesomeIcons.share_alt,
                  text: 'Chia sẻ với bạn bè',
                ),
                ExtensionListItem(
                  iconData: LineAwesomeIcons.comment,
                  text: 'Phản hồi góp ý',
                ),
                ExtensionListItem(
                  iconData: LineAwesomeIcons.user,
                  text: 'Đăng nhập',
                ),
              ],
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
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 6,
      ).copyWith(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).backgroundColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: FlatButton(
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Icon(
              this.iconData,
              size: 28,
            ),
            SizedBox(width: 15),
            Text(
              this.text,
              style: TvStyle.fontAppWithCustom(),
            ),
            Spacer(),
            Icon(
              LineAwesomeIcons.angle_right,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
