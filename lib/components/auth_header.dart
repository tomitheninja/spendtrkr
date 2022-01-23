import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'meta.lang-emoji'.tr,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text('auth.continue-anonymous'.tr.capitalizeFirst!,
                style: TextStyle(
                    color: Colors.grey[400], fontWeight: FontWeight.w300))),
      ],
    );
  }
}
