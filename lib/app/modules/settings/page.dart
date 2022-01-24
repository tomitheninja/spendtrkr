import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendtrkr/app/widgets/segmented_selector/locale_segmented_selector.dart';
import 'package:spendtrkr/app/widgets/segmented_selector/theme_segmented_selector.dart';
import 'package:spendtrkr/app/data/services/auth.dart';

class SettingsUI extends StatelessWidget {
  SettingsUI({Key? key}) : super(key: key);

  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: ListView(
        children: <Widget>[
          /* Column(children: [
            const SizedBox(height: 32),
            Stack(children: [
              CircleAvatar(
                backgroundColor: Colors.grey[900],
                radius: 64,
                backgroundImage: NetworkImage(
                    _auth.firestoreUser.value!.photoUrl ??
                        gravatarUrl(_auth.firestoreUser.value!.email)),
              ),
              Positioned(
                child: IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () {},
                ),
                bottom: -10,
                left: 80,
              ),
            ]),
            const SizedBox(height: 16),
            Text(_auth.firestoreUser.value!.name ?? '',
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 16),
            Text(
                '${'auth.email'.tr}: ${_auth.firestoreUser.value!.email ?? ''}'),
            const SizedBox(height: 32),
          ]), */
          ListTile(
            title: Text('settings.theme'.tr),
            trailing: ThemeSegmentedSelector(),
          ),
          ListTile(
            title: Text('settings.locale'.tr),
            trailing: LocaleSegmentedSelector(),
          ),
          ListTile(
            title: Text('settings.change-password'.tr),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text(
                'settings.change-password'.tr,
              ),
            ),
          ),
          ListTile(
            title: Text('settings.signout'.tr),
            trailing: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: _auth.signOut,
              child: Text(
                'settings.signout'.tr,
              ),
            ),
          )
        ],
      ),
    );
  }
}
