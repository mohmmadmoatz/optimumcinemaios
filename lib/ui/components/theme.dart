import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color mainColor = Color(0xffC70C0D);

const Color darkPrimaryColor = Color(0xff1E1E1E);
const Color darkBackgroundColor = Color(0xff161616);

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    fontFamily: GoogleFonts.tajawal().fontFamily,
    brightness: Brightness.light,
    accentColor: mainColor.withOpacity(0.9),
    primaryColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),
    accentTextTheme: TextTheme(headline1: TextStyle(color: darkPrimaryColor)),
    textTheme: TextTheme(headline1: TextStyle(color: Colors.black)),
    hintColor: Colors.black.withOpacity(0.35),
    primaryIconTheme: IconThemeData(color: Colors.black.withOpacity(.5)),
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.tajawal().fontFamily)),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    fontFamily: GoogleFonts.tajawal().fontFamily,
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    accentColor: mainColor.withOpacity(0.9),
    accentTextTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
    textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
    hintColor: Colors.white.withOpacity(0.35),
    primaryIconTheme: IconThemeData(color: Colors.white),
    cupertinoOverrideTheme: CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.tajawal().fontFamily)),
    ),
  );
}
