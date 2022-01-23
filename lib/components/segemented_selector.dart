import 'package:flutter/cupertino.dart';
import 'package:spendtrkr/models/menu_option.dart';

/// ```dart
/// SegmentedSelector(
///   menuOptions: /* list of dropdown options in key value pairs */,
///   selectedOption: /* menu option string value */,
///   onChanged: (value) => print('changed'),
///  )
/// ```
class SegmentedSelector<K> extends StatelessWidget {
  const SegmentedSelector(
      {Key? key,
      required this.menuOptions,
      required this.selectedOption,
      required this.onValueChanged})
      : super(key: key);

  final List<MenuOptions<K, String>> menuOptions;
  final K selectedOption;
  final void Function(K?) onValueChanged;

  @override
  Widget build(BuildContext context) {
    //if (Platform.isIOS) {}

    return CupertinoSlidingSegmentedControl(
        //thumbColor: Theme.of(context).primaryColor,
        groupValue: selectedOption,
        children: {
          for (var option in menuOptions)
            if (option.icon == null)
              option.key: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),
                  const SizedBox(width: 6),
                  Text(
                    option.value,
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(height: 4),
                ],
              )
            else
              option.key: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),
                  Icon(option.icon),
                  const SizedBox(width: 6),
                  Text(option.value),
                  const SizedBox(height: 4),
                ],
              )
        },
        onValueChanged: onValueChanged);
  }
}
