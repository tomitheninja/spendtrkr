import 'package:flutter/material.dart';
import 'package:spendtrkr/app/widgets/locale_dropdown_selector.dart';

import 'signup_anon_button.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [const LocaleDropdownSelector(), SignupAnonButton()],
    );
  }
}
