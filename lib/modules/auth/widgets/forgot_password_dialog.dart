import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/core/utils/validator.dart';
import 'package:spendtrkr/core/values/keys.dart';
import 'package:spendtrkr/data/services/auth.dart';

class ForgotPasswordDialog extends GetView<AuthController> {
  final emailController = TextEditingController();
  ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          0.5),
      title: Text("auth.forgot-password".tr),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: forgotPasswordFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text("auth.forgot-password.desc".tr),
              const SizedBox(height: 4),
              TextFormField(
                controller: emailController,
                validator: Validator.email,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'auth.email'.tr,
                    contentPadding: const EdgeInsets.all(11.25),
                    icon: const Icon(Icons.email)),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text("auth.forgot-password.submit".tr),
          onPressed: () async {
            Get.back(result: emailController.text);
          },
        ),
      ],
    );
  }
}
