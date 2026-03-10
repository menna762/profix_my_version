import 'package:app/utils/profixStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/utils/profix_colors.dart';

import 'profix_colors.dart' hide ProfixColors;



class ProfixTheme {
  static final ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white, // خلفية الشريط
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,   // إخفاء الـ Label الافتراضي لمنع الـ Overflow
      showUnselectedLabels: false, // إخفاء الـ Label الافتراضي لمنع الـ Overflow
      elevation: 0,
    ),
    //bottomNavigationBarTheme: BottomNavigationBarThemeData(
     // showSelectedLabels: false,   // إخفاء الاسم تماماً في حالة الاختيار
     //// showUnselectedLabels: false, // إخفاء الاسم تماماً في حالة عدم الاختيار
     // type: BottomNavigationBarType.fixed, // لتوزيع العناصر بشكل متساوي
     // elevation: 0,
   // ),
    brightness: Brightness.light,
    primaryColor: ProfixColors.primary,
    scaffoldBackgroundColor: ProfixColors.background,

    // إعدادات النصوص في الـ Light (تكون باللون الغامق #0F1729)
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ProfixColors.textMain),
      bodyMedium: TextStyle(color: ProfixColors.textMain),
      titleLarge: TextStyle(color: ProfixColors.textMain, fontWeight: FontWeight.bold),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: ProfixColors.background,
      elevation: 0,
      titleTextStyle: TextStyle(color: ProfixColors.textMain, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: ProfixColors.primary),
    ),

    // باقي الإعدادات اللي كانت عندك
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ProfixColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: Colors.white, width: 6)
        )
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E293B), // خلفية داكنة متناسقة مع ألوانك
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    //bottomNavigationBarTheme: BottomNavigationBarThemeData(
     // showSelectedLabels: false,   // إخفاء الاسم تماماً في حالة الاختيار
     /// showUnselectedLabels: false, // إخفاء الاسم تماماً في حالة عدم الاختيار
     // type: BottomNavigationBarType.fixed, // لتوزيع العناصر بشكل متساوي
     // elevation: 0,
   // ),
    brightness: Brightness.dark,
    primaryColor: ProfixColors.primary,
    scaffoldBackgroundColor: const Color(0xFF0F1729), // عكسنا الخلفية بقت لون النص القديم

    // إعدادات النصوص في الـ Dark (تكون باللون الفاتح)
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E293B), // درجة أغمق قليلاً للـ AppBar
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ProfixColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(color: Color(0xFF0F1729), width: 6)
        )
    ),
  );
}
