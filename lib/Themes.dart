import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {


  static const Color defaultColor = Color.fromRGBO(246, 200, 200, 1);
  static const Color darkColor = Colors.grey;
  static const Color coffeeColor = Color.fromRGBO(228, 183, 160, 1);
  static const Color cyanColor = Color.fromRGBO(143, 227, 235, 1);
  static const Color greenColor = Color.fromRGBO(151, 215, 178, 1);
  static const Color purpleColor = Color.fromRGBO(205, 188, 255, 1);
  static const Color blueGrayColor = Color.fromRGBO(135, 170, 171, 1);

  static final green = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.green,
        textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20))),
    iconTheme: IconThemeData(
      color: Colors.white, //修改颜色
    ),
  );

  static final yellow = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.yellow,
        textTheme:
            TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 20))),
  );

  static final red = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      color: Colors.red,
        textTheme:
        TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 20))
    ),
    iconTheme: IconThemeData(
      color: Colors.white, //修改颜色
    ),
  );

  static final black = ThemeData.dark().copyWith();

  static final white = ThemeData.light().copyWith(
    indicatorColor: Color(0xFFFE1483),
    accentColor: Color(0xFFFE1483),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        headline3: TextStyle(color: Color(0xFFFE1483),fontSize: 30),
        headline4: TextStyle(color: Color(0xFFFE1483)),
          ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFFE1483), //修改颜色
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Color(0xFFFE1483),
      unselectedLabelColor: Colors.black54,
    ),
  );
//Color(0xff90caf9)
}
