import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/data/services/auth.dart';

class AuthFormController extends GetxController {
  final auth = Get.find<AuthController>();
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final photo = Uint8List(0).obs;
}
