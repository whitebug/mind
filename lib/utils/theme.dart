import 'utils.dart';
import 'package:flutter/material.dart';

class MindfulnessTheme {
  static get theme {
    return ThemeData(
      primaryTextTheme: TextTheme(
        title: TextStyle(color: Colors.white),
      ),
      primaryColor: Colors.white,
      accentColor: eatMainColor,
      pageTransitionsTheme: PageTransitionsTheme(),
      textTheme: TextTheme(
        display4: eatTextStyle(),
        display3: eatTextStyle(),
        display2: eatTextStyle(),
        display1: eatTextStyle(),
        headline: eatTextStyle(),
        title: eatTextStyle(),
        subhead: eatTextStyle(),
        body2: eatTextStyle(),
        body1: eatTextStyle(),
        caption: eatTextStyle(),
        button: eatTextStyle(),
        subtitle: eatTextStyle(),
        overline: eatTextStyle(),
      ),
    );
  }

  static TextStyle eatTextStyle() {
    return TextStyle(
      fontFamily: 'Prata',
      fontSize: 14,
      color: Colors.black,
    );
  }
}
