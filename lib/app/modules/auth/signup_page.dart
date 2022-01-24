import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/modules/auth/widgets/auth_header.dart';
import 'package:spendtrkr/app/modules/auth/widgets/signup_bottom_nav.dart';
import 'package:spendtrkr/app/modules/auth/widgets/signup_form.dart';

class SignupUI extends StatelessWidget {
  const SignupUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('signup.title'.tr),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const AuthHeader(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: SignupForm(),
                    ),
                  ),
                ],
              ),
            ),
            const SignupBottomNav(),
          ],
        ),
      ),
    );
  }
}
