import 'package:get/get.dart';
import 'en_uk.dart';
import 'en_au.dart';
import 'hu.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_UK': enUk,
        'en_AU': enAu,
        'hu': hu,
      };
}
