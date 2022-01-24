import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/data/services/locale.dart';
import 'package:spendtrkr/core/languages/translations.dart';

class LocaleDropdownSelector extends GetView<LocaleService> {
  const LocaleDropdownSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langs = MyTranslations().keys.entries;

    return DropdownButton(
      value: controller.locale,
      style: const TextStyle(fontSize: 18),
      icon: const SizedBox.shrink(),
      underline: Container(height: 0),
      onChanged: (Locale? value) {
        if (value != null) {
          controller.locale = value;
        }
      },
      items: langs.map((e) {
        var l = e.key.split('_');
        var v = e.value;
        return DropdownMenuItem(
          value: Locale(l[0], l.length == 2 ? l[1] : null),
          child: Text("${v['meta.lang-emoji']!} ${v['meta.lang-name']!}"),
        );
      }).toList(growable: false),
    );
  }
}
