import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/settings.dart';

import '../translations.dart';

class LocaleChangerDropdown extends StatelessWidget {
  LocaleChangerDropdown({
    Key? key,
  }) : super(key: key);

  final settings = Get.find<SettingsService>();

  @override
  Widget build(BuildContext context) {
    final langs = MyTranslations().keys.entries;

    return DropdownButton(
      value: Locale(settings.locale),
      style: const TextStyle(fontSize: 18),
      icon: const SizedBox.shrink(),
      underline: Container(height: 0),
      onChanged: (Locale? newValue) {
        if (newValue != null) {
          settings.locale = newValue.languageCode;
        }
      },
      items: langs
          .map((e) => DropdownMenuItem(
                value: Locale(e.key),
                child: Text(e.value['meta.lang-emoji']! + ' ' + e.key),
              ))
          .toList(growable: false),
    );
  }
}
