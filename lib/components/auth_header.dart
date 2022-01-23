import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/settings.dart';

import '../translations.dart';

class AuthHeader extends StatelessWidget {
  AuthHeader({
    Key? key,
  }) : super(key: key);
  final settings = Get.find<SettingsService>();

  final items = MyTranslations()
      .keys
      .values
      .map((e) => {
            'key': e['meta.lang-name']!,
            'text': e['meta.lang-emoji']! + ' ' + e['meta.lang-name']!
          })
      .toList();

  @override
  Widget build(BuildContext context) {
    final langs = MyTranslations().keys.entries;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton(
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
        ),
        TextButton(
            onPressed: () {},
            child: Text('auth.continue-anonymous'.tr.capitalizeFirst!,
                style: TextStyle(
                    color: Colors.grey[400], fontWeight: FontWeight.w300))),
      ],
    );
  }
}
