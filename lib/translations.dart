import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'app.title': 'Spendtrkt',
          'home.welcome': 'Welcome to Flutter',
          'home.change-theme': 'Change theme',
          'home.change-locale': 'Change locale',
        },
        'hu': {
          'app.title': 'Spendtrkt',
          'home.welcome': 'Üdvözöllek a Flutterben',
          'home.change-theme': 'Téma váltása',
          'home.change-locale': 'Nyelv váltása',
        },
      };
}
