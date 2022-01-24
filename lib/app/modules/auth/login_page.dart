import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/modules/auth/widgets/auth_header.dart';

import 'widgets/login_bottom_nav.dart';
import 'widgets/login_form.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('login.title'.tr),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  const AuthHeader(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
            const LoginBottomNav(),
          ],
        ),
      ),
    );
  }
}
