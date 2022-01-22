import 'package:flutter/material.dart';

/*
DropdownPickerWithIcon(
                menuOptions: list of dropdown options in key value pairs,
                selectedOption: menu option string value,
                onChanged: (value) => print('changed'),
              ),
*/
class DropdownPickerWithIcon extends StatelessWidget {
 

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(String?)? onChanged;
  const DropdownPickerWithIcon(
      {Key? key,
        required this.menuOptions,
      required this.selectedOption,
      this.onChanged}): super(key: key);

  @override
  Widget build(BuildContext context) {
    //if (Platform.isIOS) {}
    return DropdownButton<String>(
        items: menuOptions
            .map((data) => DropdownMenuItem<String>(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(data.icon),
                      const SizedBox(width: 10),
                      Text(
                        data.value,
                      ),
                    ],
                  ),
                  value: data.key,
                ))
            .toList(),
        value: selectedOption,
        onChanged: onChanged);
  }
}
