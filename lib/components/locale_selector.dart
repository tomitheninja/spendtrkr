import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/settings.dart';
import 'package:spendtrkr/models/menu_option.dart';
import 'package:spendtrkr/core/values/languages/translations.dart';

import 'segemented_selector.dart';

class LocaleSelector extends GetView<SettingsService> {
  LocaleSelector({Key? key}) : super(key: key);

  final List<MenuOptions<Locale, String>> themeOptions =
      MyTranslations().keys.entries.map((e) {
    var l = e.key.split('_');
    var v = e.value;
    return MenuOptions(
      key: Locale(l[0], l.length == 2 ? l[1] : null),
      value: v['meta.lang-emoji']!,
    );
  }).toList(growable: false);

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.theme.toString());

    return SegmentedSelector(
      selectedOption: controller.locale,
      menuOptions: themeOptions,
      onValueChanged: (Locale? value) {
        if (value != null) {
          controller.locale = value;
          Get.forceAppUpdate();
        }
      },
    );
  }
}
