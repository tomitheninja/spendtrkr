import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendtrkr/constants/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:spendtrkr/helpers/helpers.dart';
import 'package:spendtrkr/controllers/controllers.dart';

class SignInUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignInUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 900,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.signup);
                      },
                      child: const Text(
                        "Don't have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      TextFormField(
                        validator: Validator().email,
                        controller: authController.emailController,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        validator: Validator().password,
                        controller: authController.passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
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
                                'Forgot password?',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                if (_formKey.currentState!.validate()) {
                                  await authController
                                      .signInWithEmailAndPassword(context);
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
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    const url = 'https://github.com/tomitheninja';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Get.snackbar('Could not launch', url,
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Column(
                    children: [
                      Text("Made with",
                          style: TextStyle(
                            color: Colors.grey[600],
                          )),
                      Icon(
                        Icons.favorite,
                        color: Colors.grey[600],
                      ),
                      Text(
                        "By Tamás Südi",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
