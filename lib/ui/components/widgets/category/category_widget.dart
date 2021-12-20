import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/model/Catmodel.dart';
import 'package:cinema_project/ui/screens/sub/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  final CatagoryModel catagoryModel;
  final int navId;

  CategoryWidget({
    Key key,
    @required this.navId,
    this.catagoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => Get.to(Category(
        initialIndex: navId,
        catagoryModel: catagoryModel,
      )),
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(.47), BlendMode.darken),
                    image: CachedNetworkImageProvider(catagoryModel.poster),
                    fit: BoxFit.cover)),
            child: Center(
              child: Text(catagoryModel.name.toUpperCase() ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.8,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}
