import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/api/download.dart';
import 'package:cinema_project/splashscreen.dart';
import 'package:cinema_project/ui/components/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  Get.config(defaultTransition: Transition.cupertino);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en', 'US'), Locale('ar', 'IQ')],
    path: 'assets/languages',
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider<CatRepo>(create: (_) => CatRepo()),
          ChangeNotifierProvider<MovieRepo>(create: (_) => MovieRepo()),
          ChangeNotifierProvider<DownloadApi>(create: (_) => DownloadApi()),
        ],
        child: MaterialApp(
          title: 'Optimum Cinema',
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: darkTheme(context),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            EasyLocalization.of(context).delegate,
          ],
          supportedLocales: EasyLocalization.of(context).supportedLocales,
          locale: EasyLocalization.of(context).locale,
          home: Spachscreen(),
        ));
  }
}

bool iphone = true;
