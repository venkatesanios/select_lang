import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_lang/secondpage.dart';
import 'package:select_lang/testlanguage/langsample..dart';

class HomePagelanguage extends StatelessWidget {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'ಕನ್ನಡ', 'locale': Locale('kn', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('title'.tr),
        ),
        drawer: SafeArea(
          child: Drawer(
            elevation: 2,
            child: ListTile(
              title: Text('testSQL table'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Langsample(),
                  ),
                );
              },
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const Langsample()));
              // },
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'hello'.tr,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'message'.tr,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'subscribe'.tr,
                style: TextStyle(fontSize: 17),
              ),
              ElevatedButton(
                  onPressed: () {
                    buildLanguageDialog(context);
                  },
                  child: Text('changelang'.tr)),
              SizedBox(
                height: 100,
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const secondPage(),
                    ),
                  );
                },
                child: Icon(Icons.add_box),
              ),
            ],
          ),
        ));
  }
}
