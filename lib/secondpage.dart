import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class secondPage extends StatefulWidget {
  const secondPage({super.key});

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('title2'.tr)),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: [
          Text('hello'.tr),
          SizedBox(),
          Text('hello'.tr),
          SizedBox(),
          Text('message'.tr),
          SizedBox(),
          Text('title'.tr),
          SizedBox(),
          Text('changelang'.tr),
          SizedBox(),
          Text('title2'.tr),
        ]),
        // Text(translate('language.selected_message',
        //      args: {'language': translate('language.name.ar')})),
      ),
    );
  }
}
