import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/components/auth_header.dart';
import 'package:spendtrkr/components/login_bottom_nav.dart';
import 'package:spendtrkr/components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
