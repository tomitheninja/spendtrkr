import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/components/auth_header.dart';
import 'package:spendtrkr/screens/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('login.title'.tr.capitalizeFirst!),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: LoginBody(),
            ),
            const LoginBottomNav(),
          ],
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  LoginBody({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Flex(
        direction: Axis.vertical,
        children: [
          AuthHeader(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 100),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "login.welcome".tr.capitalizeFirst!,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(147, 148, 184, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      // validator: Validator().email,
                      // controller: authController.emailController,

                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'auth.email'.tr,
                          contentPadding: const EdgeInsets.all(11.25),
                          icon: const Icon(Icons.email)),
                    ),
                    TextFormField(
                      //   validator: Validator().password,
                      //   controller: authController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'auth.password'.tr,
                          contentPadding: const EdgeInsets.all(11.25),
                          icon: const Icon(Icons.lock)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'auth.forgot-password'.tr.capitalizeFirst!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              if (_formKey.currentState!.validate()) {
                                //         await authController
                                //               .signInWithEmailAndPassword(context);
                              }
                            } on FirebaseAuthException catch (e) {
                              switch (e.code) {
                                case 'invalid-email':
                                  Get.snackbar(
                                      "Error", "Invalid email address");
                                  break;
                                case 'user-disabled':
                                  Get.snackbar("Error", "User is disabled");
                                  break;
                                case 'user-not-found':
                                case 'wrong-password':
                                  Get.snackbar(
                                      "Error", "Invalid email or password");
                                  break;
                                default:
                                  Get.snackbar("Error", "An error occurred");
                                  break;
                              }
                            } catch (e) {
                              Get.snackbar("Error", e.toString());
                            }
                          },
                          child: Text('login.button-text'.tr.capitalizeFirst!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginBottomNav extends StatelessWidget {
  const LoginBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 5) {
          // swiping in right direction
          Get.to(const SignupPage(), transition: Transition.leftToRight);
        } else if (details.delta.dx < -5) {
          // swiping in left direction
          Get.to(const SignupPage(), transition: Transition.rightToLeft);
        } else if (details.delta.dy.abs() > 5) {
          Get.to(const SignupPage(), transition: Transition.downToUp);
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: RawMaterialButton(
          onPressed: () => Get.to(
            const SignupPage(),
            transition: Transition.downToUp,
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 800),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 32, top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.keyboard_arrow_up),
                    const SizedBox(height: 8),
                    Text(
                      "login.signup".tr.capitalize!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
