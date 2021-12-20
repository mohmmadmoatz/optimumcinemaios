import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/ui/screens/sub/search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final bool preview;

  const SearchBar({Key key, this.searchController, this.preview = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 40.0,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .textTheme
                      .headline1
                      .color
                      .withOpacity(0.04),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      FeatherIcons.search,
                      color: Theme.of(context)
                          .textTheme
                          .headline1
                          .color
                          .withOpacity(0.78),
                      size: 23,
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {
                          Provider.of<MovieRepo>(context, listen: false)
                              .search(value);
                        },
                        controller: searchController,
                        cursorColor: Theme.of(context).accentColor,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: tr('searchHint'),
                          hintStyle: TextStyle(
                              height: 2.2,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .color
                                  .withOpacity(0.42),
                              fontSize: 15),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 5, left: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (preview)
                CupertinoButton(
                  onPressed: () =>
                      Get.to(Search(), transition: Transition.fadeIn),
                  child: Container(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
