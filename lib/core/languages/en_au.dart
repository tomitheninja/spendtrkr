import 'package:flutter/foundation.dart';
import 'package:spendtrkr/core/utils/flip_text.dart';

import 'en_uk.dart';

Map<String, String> enAu = {
  ...enUk,
  ...flipMap(kDebugMode ? enUk : {}),
  'meta.lang-name': 'au',
  'meta.lang-emoji': '🇦🇺'
};
