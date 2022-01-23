import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAnonButton extends StatelessWidget {
  const LoginAnonButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'auth.continue-anonymous'.tr,
        style: TextStyle(
          color: Colors.grey[400],
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
