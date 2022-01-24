import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

String gravatar(String email) =>
    'https://www.gravatar.com/avatar/${md5.convert(utf8.encode(email)).toString()}?d=mp';

class Avatar extends StatelessWidget {
  final ImageProvider image;
  final ImageProvider? overrideImage;
  const Avatar({
    Key? key,
    required this.image,
    this.overrideImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return overrideImage != null
        ? CircleAvatar(
            radius: 64,
            backgroundImage: overrideImage!,
          )
        : CircleAvatar(
            radius: 64,
            backgroundImage: image,
          );
  }
}
