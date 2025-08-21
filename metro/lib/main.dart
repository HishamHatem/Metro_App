import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Metro Guide',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light, // This allows Get.changeTheme() to work
        transitionDuration: Duration(milliseconds: 300),
        home: FirstPage()
    );
  }
}
