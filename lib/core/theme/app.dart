import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static final light = ThemeData.light();

  static final dark =
      ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black);
}
