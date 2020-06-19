import 'package:comicappflutter/base/base_widget.dart';
import 'package:comicappflutter/data/remote/category_service.dart';
import 'package:comicappflutter/data/repo/category_repo.dart';
import 'package:comicappflutter/module/category/category_bloc.dart';
import 'package:comicappflutter/shared/app_color.dart';
import 'package:comicappflutter/shared/model/category.dart';
import 'package:comicappflutter/shared/style/tv_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Thể Loại',
      isCenterTitle: true,
      di: [
        Provider.value(
          value: CategoryService(),
        ),
        ProxyProvider<CategoryService, CategoryRepo>(
          update: (context, categoryService, _) =>
              CategoryRepo(categoryService: categoryService),
        ),
      ],
      bloc: [],
      child: CategoryListWidget(),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CategoryBloc.getInstance(
        categoryRepo: Provider.of(context),
      ),
      child: Consumer<CategoryBloc>(builder: (context, bloc, child) {
        bloc.getCategory();
        return StreamProvider<List<Category>>.value(
          value: bloc.categoryStream,
          initialData: null,
          catchError: (context, error) {
            return error;
          },
          child: Consumer<List<Category>>(
            builder: (_, data, child) {
              if (data == null) {
                return Container(
                  height: 170,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColor.blue,
                    ),
                  ),
                );
              }

              var categoryList = data;
              return Container(
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    // số lượng cột trong 1 hàng
                    mainAxisSpacing: 5,
                    // khoảng cách giữa các thằng con theo trục dọc
                    crossAxisSpacing: 5,
                    // khoảng cách giữa các cột theo trục ngang
                    padding: EdgeInsets.all(5),
                    childAspectRatio: 0.5,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: categoryList
                        .map((category) => _buildItemGrid(category))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildItemGrid(Category category) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
        category.name,
        textAlign: TextAlign.center,
      )),
    );
  }
}
