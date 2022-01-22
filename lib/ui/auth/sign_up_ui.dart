import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/controllers/controllers.dart';
import 'package:spendtrkr/helpers/validator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class SignUpUI extends StatelessWidget {
  SignUpUI({Key? key}) : super(key: key);
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Obx(
                              () => authController.photo.isEmpty
                                  ? CircleAvatar(
                                      backgroundColor: Colors.grey[900],
                                      radius: 64,
                                      backgroundImage: const AssetImage(
                                          'assets/images/birds.png'))
                                  : CircleAvatar(
                                      backgroundColor: Colors.grey[900],
                                      radius: 64,
                                      backgroundImage:
                                          MemoryImage(authController.photo)),
                            ),
                            Positioned(
                              child: IconButton(
                                iconSize: 32,
                                icon: const Icon(Icons.add_photo_alternate),
                                onPressed: authController.selectImage,
                              ),
                              bottom: -10,
                              left: 80,
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: Validator().name,
                          controller: authController.nameController,
                          autofocus: true,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                        ),
                        TextFormField(
                          validator: Validator().email,
                          controller: authController.emailController,
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
                        TextFormField(
                          validator: authController.passwordAgainValidator,
                          controller: authController.passwordAgainController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: 'Password again'),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    SystemChannels.textInput.invokeMethod(
                                        'TextInput.hide'); //to hide the keyboard - if any
                                    await authController
                                        .signupWithEmailAndPassword(context);
                                  }
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
                              child: const Text('Create account'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                      const Text("Terms of Service"),
                      const SizedBox(width: 8),
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
