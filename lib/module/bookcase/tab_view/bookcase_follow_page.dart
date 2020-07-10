import 'dart:convert';

import 'package:comicappflutter/module/bookcase/bookcase_bloc.dart';
import 'package:flutter/material.dart';

class BookcaseFollowPage extends StatefulWidget {
  final BookcaseBloc bloc;

  BookcaseFollowPage({this.bloc});

  @override
  _BookcaseFollowPageState createState() => _BookcaseFollowPageState();
}

class _BookcaseFollowPageState extends State<BookcaseFollowPage> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies bookcase');
  }

  @override
  Widget build(BuildContext context) {
    print('bookcase follow rebuild');
    return Container(
      child: Text('Theo dõi'),
    );
  }
}
