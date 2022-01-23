import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/components/auth_header.dart';
import 'package:spendtrkr/components/signup_bottom_nav.dart';
import 'package:spendtrkr/components/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Flex(
                  direction: Axis.vertical,
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
            ),
            const SignupBottomNav(),
          ],
        ),
      ),
    );
  }
}
