// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                        Get.toNamed("/signup");
                      },
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      TextFormField(
                        validator: controller.emailValidator,
                        controller: controller.emailController,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        validator: controller.passwordValidator,
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 8),
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
                            onPressed: controller.login,
                            child: Text('Login'),
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
