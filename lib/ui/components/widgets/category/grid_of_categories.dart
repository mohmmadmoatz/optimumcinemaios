import 'package:cinema_project/model/Catmodel.dart';
import 'package:cinema_project/ui/components/widgets/category/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GridOfCategories extends StatelessWidget {
  final String title, buttonText;
  final Function buttonFunction;
  final List<CatagoryModel> categories;

  const GridOfCategories(
      {Key key,
      this.title,
      this.buttonText,
      this.buttonFunction,
      @required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 5 / 3),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 675),
              child: FadeInAnimation(
                child: CategoryWidget(
                  catagoryModel: categories[index],
                  navId: 0,
                ),
              ),
            );
          }),
    );
  }
}
