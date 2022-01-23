import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxController {
  final _storage = GetStorage();
  var _theme = ThemeMode.system;
  var _locale = 'en';

  // get and set locale
  String get locale => _locale;
  set locale(String value) {
    _locale = value;
    _storage.write('locale', value.toString());
    Get.updateLocale(Locale(value));
    update();
  }

  // get and set for theme
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    _storage.write('theme', value.toString());
    Get.changeThemeMode(value);
    update();
  }

  @override
  void onInit() {
    theme = _parseTheme(_storage.read('theme'));
    locale = _storage.read('locale') ?? 'en';
    print('theme $theme');
    print('locale $locale');
    super.onInit();
    update();
  }

  // function to parse ThemeMode from String
  ThemeMode _parseTheme(String? value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
      default:
        return ThemeMode.system;
    }
  }
}
