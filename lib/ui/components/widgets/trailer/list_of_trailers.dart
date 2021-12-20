import 'package:cinema_project/ui/components/widgets/trailer/trailer_widget.dart';
import 'package:cinema_project/ui/components/widgets/widget_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListOfTrailers extends StatelessWidget {
  final String title, buttonText;
  final Function buttonFunction;
  final List<Map<String, dynamic>> trailers;

  const ListOfTrailers(
      {Key key,
      @required this.title,
      @required this.buttonText,
      this.buttonFunction,
      @required this.trailers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetHeader(
      title: title,
      button: InkWell(
          onTap: buttonFunction,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(buttonText,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Icon(FeatherIcons.chevronRight, size: 20),
            ],
          )),
      child: Container(
        height: 170,
        child: AnimationLimiter(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
              shrinkWrap: true,
              itemCount: trailers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 675),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: AspectRatio(
                      aspectRatio: 15 / 9,
                      child: TrailerWidget(
                        image: trailers[index]['image'],
                        title: trailers[index]['title'],
                        navId: 0,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
