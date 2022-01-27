import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/app_binding.dart';
import 'package:parking/app/modules/account/account_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Estacionamento',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff334560, color),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AccountView(),
      initialBinding: AppBinding(),
    );
  }

  static Map<int, Color> color = {
    50: const Color.fromRGBO(227, 230, 235, .1),
    100: const Color.fromRGBO(227, 230, 235, .2),
    200: const Color.fromRGBO(227, 230, 235, .3),
    300: const Color.fromRGBO(227, 230, 235, .4),
    400: const Color.fromRGBO(227, 230, 235, .5),
    500: const Color.fromRGBO(227, 230, 235, .6),
    600: const Color.fromRGBO(227, 230, 235, .7),
    700: const Color.fromRGBO(227, 230, 235, .8),
    800: const Color.fromRGBO(227, 230, 235, .9),
    900: const Color.fromRGBO(227, 230, 235, 1),
  };
}
