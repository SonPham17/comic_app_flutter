import 'package:comicappflutter/base/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMorePage extends StatefulWidget {
  @override
  _LoadMorePageState createState() => _LoadMorePageState();
}

class _LoadMorePageState extends State<LoadMorePage> {
  static const double _endReachedThreshold =
      100; // cách bottom 200px thì loadmore

  final ScrollController _controller = ScrollController();

//  List<ColorInformation> _colors = [];

  int _nextPage = 1;
  bool _loading = true;
  bool _canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    print('_onScroll');
    if (!_controller.hasClients || _loading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      _getColors();
    }
  }

  Future<void> _refresh() async {
    _canLoadMore = true;
//    _colors.clear();
    _nextPage = 1;
    await _getColors();
  }

  Widget _buildColorItem(BuildContext context, int index) {
    return ColorItem(_colors[index]);
  }

  Future<void> _getColors() async {
    _loading = true;

    final newColors = await getColorsFromServer(page: _nextPage, limit: _itemsPerPage);

    setState(() {
      _colors.addAll(newColors);

      _nextPage++;

      if (newColors.length < _itemsPerPage) {
        _canLoadMore = false;
      }

      _loading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var result = ModalRoute.of(context).settings.arguments as Map;
    print(result['title']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            onRefresh: _refresh,
          ),
          SliverPadding(
            padding: EdgeInsets.all(5),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.6,
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                _buildColorItem,
                childCount: _colors.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _canLoadMore
                ? Container(
                    padding: EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }
}
