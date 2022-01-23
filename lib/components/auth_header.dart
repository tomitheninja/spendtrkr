import 'package:flutter/material.dart';
import 'locale_changer_dropdown.dart';
import 'signup_anon_button.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [LocaleChangerDropdown(), SignupAnonButton()],
    );
  }
}
