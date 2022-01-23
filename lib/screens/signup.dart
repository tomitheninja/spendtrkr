import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/components/auth_header.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('signup.title'.tr.capitalizeFirst!),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: SignupBody(),
            ),
            const SignupBottomNav(),
          ],
        ),
      ),
    );
  }
}

class SignupBody extends StatelessWidget {
  SignupBody({
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
          const AuthHeader(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 100),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            radius: 64,
                            backgroundImage:
                                const AssetImage('assets/images/birds.png')),
                        Positioned(
                          child: IconButton(
                            iconSize: 32,
                            icon: const Icon(Icons.add_photo_alternate),
                            onPressed: () => {},
                          ),
                          bottom: -10,
                          left: 80,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      // validator: Validator().email,
                      // controller: authController.emailController,
                      decoration: InputDecoration(
                        labelText: 'signup.username'.tr,
                        icon: const Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      // validator: Validator().email,
                      // controller: authController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'auth.email'.tr,
                        icon: const Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      //   validator: Validator().password,
                      //   controller: authController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'auth.password'.tr,
                        icon: const Icon(Icons.lock),
                      ),
                    ),
                    TextFormField(
                      //   validator: Validator().password,
                      //   controller: authController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'signup.password-again'.tr,
                        icon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                          child: Text('signup.button-text'.tr.capitalizeFirst!),
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

class SignupBottomNav extends StatelessWidget {
  const SignupBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        Get.back();
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.only(bottom: 20, top: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "signup.login".tr,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: Get.back,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
