import 'package:cinema_project/ui/components/widgets/series/series_widget.dart';
import 'package:cinema_project/ui/components/widgets/widget_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cinema_project/model/SeriseModal.dart';

class ListOfSeries extends StatelessWidget {
  final String title, buttonText;
  final Function buttonFunction;
  final List<SeriseModal> series;

  const ListOfSeries(
      {Key key, this.title, this.buttonText, this.buttonFunction, this.series})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetHeader(
      title: title,
      button: buttonFunction == null
          ? Container()
          : InkWell(
              onTap: buttonFunction,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(buttonText,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  Icon(FeatherIcons.chevronRight, size: 20),
                ],
              )),
      child: Container(
        height: 200,
        child: AnimationLimiter(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
              itemCount: series.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 675),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: AspectRatio(
                      aspectRatio: 12 / 9,
                      child: SeriesWidget(
                        seriseModal: series[index],
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
