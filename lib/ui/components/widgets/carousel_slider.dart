import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/model/SeriseModal.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/screens/sub/movie.dart';
import 'package:cinema_project/ui/screens/sub/series.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CarouselSlider extends StatelessWidget {
  final PageController carouselController;
  @required
  final List image;
  const CarouselSlider({Key key, this.carouselController, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: PageView.builder(
        controller: carouselController,
        itemCount: image.length,
        itemBuilder: (BuildContext context, int index) => CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            imageUrl: image[index]["appurl"] ??
                "http://93.191.114.168/optimumcinema/public/img/logo.png",
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => ClipRect(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          String idd = "";
                          if (image[index]["link"]
                              .toString()
                              .contains("movies")) {
                            idd = image[index]["link"]
                                .toString()
                                .split("movies/")[1];
                          } else {
                            idd = image[index]["link"]
                                .toString()
                                .split("series/")[1];
                          }

                          http
                              .get(Uri.parse(
                                  "http://10.24.24.206/optimumcinema/public/api/findmoviefromslifeshow/" +
                                      idd))
                              .then((value) {
                            var tempdata = (value.body);
                            var c = json.decode(tempdata);
//                            _progressDialog.dismissProgressDialog(context);

                            if (image[index]["link"]
                                .toString()
                                .contains("movies")) {
                              Get.to(Movie(
                                moviemodal: Moviemodal.fromJson(c["data"]),
                              ));
                            } else {
                              Get.to(Series(
                                seriseModal: SeriseModal.fromJson(c["data2"]),
                              ));
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  blurRadius: 100,
                                  spreadRadius: 100,
                                  offset: Offset(0, 40))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 330),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  image[index]["name"] ?? '',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            placeholder: (context, url) => Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                      child: InkWell(
                          onTap: () {}, child: CircularProgressIndicator())),
                )),
      ),
    );
  }
}
