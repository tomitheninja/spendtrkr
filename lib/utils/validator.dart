import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:password_strength/password_strength.dart';

class Validator {
  Validator._();

  static final email = MultiValidator([
    RequiredValidator(errorText: 'validator.email-required'.tr),
    EmailValidator(errorText: 'validator.email'.tr),
  ]);

  static final password = MultiValidator([
    RequiredValidator(errorText: 'validator.password-required'.tr),
    MinLengthValidator(8, errorText: 'validator.password-length'.trArgs(['8'])),
    PasswordStrength(errorText: 'validator.password-strength'.tr)
  ]);
}

class PasswordStrength extends TextFieldValidator {
  final double strength;
  PasswordStrength({this.strength = 0.5, required String errorText})
      : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return estimatePasswordStrength(value!) > strength;
  }

  @override
  String? call(String? value) {
    return isValid(value) ? null : errorText;
  }
}
