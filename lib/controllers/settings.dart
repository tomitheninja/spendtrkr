import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxController {
  final _storage = GetStorage();
  var _theme = ThemeMode.system;
  String _language = 'en';
  String? _country;

  // get and set locale
  Locale get locale => Locale(_language, _country);
  set locale(Locale value) {
    _language = value.languageCode;
    _country = value.countryCode;
    _storage.write('language', _language);
    _storage.write('country', _country);
    Get.updateLocale(value);
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
    locale =
        Locale(_storage.read('language') ?? 'en', _storage.read('country'));
    super.onInit();
    update();
  }

  bool get isDarkMode {
    return theme == ThemeMode.dark ||
        theme == ThemeMode.system &&
            WidgetsBinding.instance?.window.platformBrightness ==
                Brightness.dark;
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
