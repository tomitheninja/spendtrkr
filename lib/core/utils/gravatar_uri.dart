import 'dart:convert';
import 'package:crypto/crypto.dart';

String gravatarUrl(String? email) =>
    'https://www.gravatar.com/avatar/${md5.convert(utf8.encode(email ?? '')).toString()}?d=mp';
