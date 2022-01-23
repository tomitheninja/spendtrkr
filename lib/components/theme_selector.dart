import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/settings.dart';
import 'package:spendtrkr/models/menu_option.dart';

import 'segemented_selector.dart';

class ThemeSelector extends GetView<SettingsService> {
  ThemeSelector({Key? key}) : super(key: key);

  final List<MenuOptions<ThemeMode, String>> themeOptions = [
    MenuOptions(
        key: ThemeMode.light,
        value: 'theme.light'.tr,
        icon: Icons.brightness_low),
    MenuOptions(
        key: ThemeMode.system,
        value: 'theme.system'.tr,
        icon: Icons.brightness_4),
    MenuOptions(
      key: ThemeMode.dark,
      value: 'theme.dark'.tr,
      icon: Icons.brightness_3,
    )
  ];

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.theme.toString());

    return SegmentedSelector(
      selectedOption: controller.theme,
      menuOptions: themeOptions,
      onValueChanged: (ThemeMode? value) {
        if (value != null) {
          controller.theme = value;
          Get.forceAppUpdate();
        }
      },
    );
  }
}
