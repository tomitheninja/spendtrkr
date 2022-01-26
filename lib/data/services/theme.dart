import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  final _theme = ThemeMode.dark.obs;
  late GetStorage box;

  ThemeMode get theme => _theme.value;
  set theme(ThemeMode value) {
    _theme.value = value;
    box.write('theme', value.toString());
    Get.changeThemeMode(value);
  }

  Future<ThemeService> init() async {
    box = GetStorage();
    await box.writeIfNull('theme', theme.toString());
    theme = parseTheme(await box.read('theme'));
    return this;
  }

  // function to parse ThemeMode from String
  static ThemeMode parseTheme(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
      default:
        return ThemeMode.dark;
    }
  }
}
