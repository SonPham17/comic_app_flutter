import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/extension_service.dart';
import 'package:comicappflutter/data/repo/extension_repo.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

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

class ExtensionListWidget extends StatefulWidget {
  @override
  _ExtensionListWidgetState createState() => _ExtensionListWidgetState();
}

class _ExtensionListWidgetState extends State<ExtensionListWidget> {
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
//    appStoreIdentifier: '',
//    googlePlayIdentifier: '',
  );

  void clickRate() {
    _rateMyApp.init().then((value) {
      _rateMyApp.showStarRateDialog(
        context,
        title: 'Rate Novel Galaxy App',
        message: 'Please leave a rating!',
        actionsBuilder: (context, starts) {
          return [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                if (starts != null) {
                  _rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed)
                      .then((_) => Navigator.pop<RateMyAppDialogButton>(
                          context, RateMyAppDialogButton.rate));
                }
              },
            )
          ];
        },
        dialogStyle: DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.only(bottom: 20.0),
        ),
        starRatingOptions: StarRatingOptions(),
      );
    });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> feedback() async {
    await FlutterShare.share(
        title: 'Phản hồi',
        text: 'Liên hệ phản hồi: ',
        linkUrl: 'novelgalaxy@gmail.com',
        chooserTitle: 'Feedback Chooser Title');
  }

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
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/main_icon.png',
                    ),
                    fit: BoxFit.fill,
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
          SizedBox(
            height: 25,
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              ExtensionListItem(
                iconData: Icons.star,
                text: 'Đánh giá ứng dụng',
                onPressed: clickRate,
              ),
              ExtensionListItem(
                iconData: Icons.share,
                text: 'Chia sẻ với bạn bè',
                onPressed: share,
              ),
              ExtensionListItem(
                iconData: Icons.comment,
                text: 'Phản hồi góp ý',
                onPressed: feedback,
              ),
              ExtensionListItem(
                iconData: Icons.supervised_user_circle,
                text: 'Đăng nhập',
              ),
            ],
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
  final Function onPressed;

  ExtensionListItem(
      {this.iconData, this.text, this.hasNavigation = false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 6,
      ).copyWith(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black38,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: FlatButton(
        onPressed: onPressed,
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
              Icons.chevron_right,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
