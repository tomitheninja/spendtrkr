import 'package:flutter/material.dart';
import 'package:spendtrkr/models/models.dart';
import 'package:spendtrkr/ui/components/components.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl == '') {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: ClipOval(
            child: Image.network(
              user.photoUrl,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
