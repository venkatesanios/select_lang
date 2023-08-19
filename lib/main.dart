import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_lang/homePage.dart';
import 'package:select_lang/testlanguage/langsample..dart';
import 'package:select_lang/testlanguage/languagetest.dart';
import 'package:select_lang/localeString.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var GlobalCupertinoLocalizations;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: Locale('en', 'US'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // locale: Locale('ta'),

      supportedLocales: [Locale('en'), Locale('ta')],
      // home: LanguageScreen(),
      // home: Langsample(),
      home: HomePagelanguage(),
    );
  }
}
