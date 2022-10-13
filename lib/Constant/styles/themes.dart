import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Colors_Style.dart';

ThemeData lightTheme = ThemeData(
  backgroundColor: const Color(0xFFF5F6F9),

  fontFamily: 'Janna',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Janna',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppStyle.kPrimaryColor,
    elevation: 20,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
);
ThemeData darkTheme = ThemeData(
  backgroundColor: Colors.black,

  fontFamily: 'Janna',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),

  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      fontFamily: 'Janna',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppStyle.kPrimaryColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 20,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
);
