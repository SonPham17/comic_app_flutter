import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/extension_service.dart';
import 'package:comicappflutter/data/repo/extension_repo.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                  AppColor.green,
                  Colors.green,
                ])),
          ),
          Column(
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
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://bloganchoi.com/wp-content/uploads/2017/03/naruto-uzumaki.jpg',
                      ),
                    ),
                  ),
                ],
              ),
              Text('Pham Trung Son',
                  style: TvStyle.fontAppWithCustom(
                      size: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            margin: EdgeInsets.only(top: 280),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context,index)=>Card(
                  child: Container(
                    color: Colors.green,
                    margin: EdgeInsets.all(4.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
