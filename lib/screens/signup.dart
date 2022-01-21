// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/signup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                        Get.back();
                      },
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: controller.signupFormKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Obx(
                            () => controller.avatar.isEmpty
                                ? CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    radius: 64,
                                    backgroundImage:
                                        AssetImage('assets/birds.png'))
                                : CircleAvatar(
                                    backgroundColor: Colors.grey[900],
                                    radius: 64,
                                    backgroundImage:
                                        MemoryImage(controller.avatar)),
                          ),
                          Positioned(
                            child: IconButton(
                              iconSize: 32,
                              icon: Icon(Icons.add_photo_alternate),
                              onPressed: controller.selectImage,
                            ),
                            bottom: -10,
                            left: 80,
                          ),
                        ],
                      ),
                      TextFormField(
                        validator: controller.usernameValidator,
                        controller: controller.usernameController,
                        autofocus: true,
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                      TextFormField(
                        validator: controller.emailValidator,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        validator: controller.passwordValidator,
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                      TextFormField(
                        validator: controller.passwordAgainValidator,
                        controller: controller.passwordAgainController,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: 'Password again'),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              try {
                                controller.signup();
                                Get.snackbar(
                                    "Success", "Signed up successfully");
                              } on FirebaseAuthException catch (e) {
                                switch (e.code) {
                                  case 'email-already-in-use':
                                    Get.snackbar(
                                        "Error", "Email already in use");
                                    break;
                                  case 'invalid-email':
                                    Get.snackbar("Error", "Invalid email");
                                    break;
                                  case 'weak-password':
                                    Get.snackbar(
                                        "Error", "Password is too weak");
                                    break;
                                  case 'operation-not-allowed':
                                    Get.snackbar("Error",
                                        "Signing up using this method is disabled");
                                    break;
                                  default:
                                    Get.snackbar("Error", "Unknown error");
                                }
                              }
                            },
                            child: Text('Create account'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    const url = 'https://github.com/tomitheninja/spendtrkr';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Get.snackbar('Could not launch', url,
                          backgroundColor: Colors.red);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Terms of Service"),
                      SizedBox(width: 8),
                      Icon(
                        Icons.auto_stories_rounded,
                        color: Colors.grey[600],
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
