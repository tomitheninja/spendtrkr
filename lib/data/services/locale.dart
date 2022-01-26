import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleService extends GetxService {
  final _locale = const Locale('en').obs;
  late GetStorage box;

  Locale get locale => _locale.value;
  set locale(Locale value) {
    _locale.value = value;
    box.write('locale', value.toString());
    Get.updateLocale(value);
  }

  Future<LocaleService> init() async {
    box = GetStorage();
    await box.writeIfNull('locale', locale.toString());
    locale = parseLocale(await box.read('locale'));
    return this;
  }

  // Parse locale from string
  static Locale parseLocale(String value) {
    final parts = value.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }
}
