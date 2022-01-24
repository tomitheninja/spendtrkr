import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/data/models/menu_option.dart';
import 'package:spendtrkr/app/data/services/locale.dart';
import 'package:spendtrkr/app/widgets/segmented_selector/segemented_selector.dart';
import 'package:spendtrkr/core/languages/translations.dart';

class LocaleSegmentedSelector extends GetView<LocaleService> {
  LocaleSegmentedSelector({Key? key}) : super(key: key);

  final themeOptions = MyTranslations().keys.entries.map((e) {
    var v = e.value;
    return MenuOptions(
      key: LocaleService.parseLocale(e.key),
      value: v['meta.lang-emoji']!,
    );
  }).toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return SegmentedSelector(
      selectedOption: controller.locale,
      menuOptions: themeOptions,
      onValueChanged: (Locale? value) {
        if (value != null) {
          controller.locale = value;
        }
      },
    );
  }
}
