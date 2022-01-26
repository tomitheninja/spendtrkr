import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/models/menu_option.dart';
import 'package:spendtrkr/data/services/theme.dart';
import 'package:spendtrkr/widgets/segmented_selector/segemented_selector.dart';

class ThemeSegmentedSelector extends GetView<ThemeService> {
  ThemeSegmentedSelector({Key? key}) : super(key: key);

  final List<MenuOptions<ThemeMode, String>> themeOptions = [
    MenuOptions(
        key: ThemeMode.light,
        value: 'theme.light'.tr,
        icon: Icons.brightness_high),
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
    return Obx(
      () => SegmentedSelector(
        selectedOption: controller.theme,
        menuOptions: themeOptions,
        onValueChanged: (ThemeMode? value) {
          if (value != null) {
            controller.theme = value;
          }
        },
      ),
    );
  }
}
