import 'package:flutter/material.dart';
/*
DropdownPicker(
                menuOptions: list of dropdown options in key value pairs,
                selectedOption: menu option string value,
                onChanged: (value) => print('changed'),
              ),
*/

class DropdownPickerWithIcon extends StatelessWidget {
  DropdownPickerWithIcon(
      {this.menuOptions, this.selectedOption, this.onChanged});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: menuOptions
            .map((data) => DropdownMenuItem<String>(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(data.icon),
                      SizedBox(width: 10),
                      Text(
                        data.key,
                      ),
                    ],
                  ),
                  value: data.value,
                ))
            .toList(),
        value: selectedOption,
        onChanged: onChanged);
  }
}
