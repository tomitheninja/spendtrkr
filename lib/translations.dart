import 'package:get/get.dart';
import 'package:spendtrkr/utils/flip_text.dart';

Map<String, String> def = {
  'meta.lang-emoji': '🇬🇧',
  'meta.lang-name': 'en',
  'error': 'Error',
  'app.title': 'Spendtrkt',
  'home.welcome': 'Welcome to Flutter',
  'home.change-theme': 'Change theme',
  'home.change-locale': 'Change locale',
  'login.title': 'Login',
  'login.button-text': 'login',
  'login.signup': 'Sign Up',
  'login.welcome': 'Welcome back',
  'signup.title': 'Sign Up',
  'signup.button-text': 'Sign Up',
  'signup.login': 'login',
  'signup.username': 'username',
  'signup.password-again': 'password again',
  'auth.forgot-password': 'Forgot Password?',
  'auth.continue-anonymous': 'Continue without account',
  'auth.email': 'email',
  'auth.password': 'password',
  'validator.password-required': 'password is required',
  'validator.password-length': 'password must be at least @1 digits long',
  'validator.password-strength': 'not secure enough',
  'validator.email': "invalid email",
  'validator.email-required': "required",
  'firebase.auth.invalid-email': "invalid email",
  "firebase.auth.user-disabled": "user disabled",
  "firebase.auth.wrong-password": "invalid credentials",
  "firebase.auth.unknown-error": 'unknown error',
};

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_UK': {
          ...def,
          'meta.lang-emoji': '🇬🇧',
          'meta.lang-name': 'en',
        },
        'hu': {
          ...def,
          'meta.lang-emoji': '🇭🇺',
          'meta.lang-name': 'hu',
          'error': 'Hiba',
          'app.title': 'Spendtrkt',
          'home.welcome': 'Üdvözöllek a Flutterben',
          'home.change-theme': 'Téma váltása',
          'home.change-locale': 'Nyelv váltása',
          'login.title': 'Bejelentkezés',
          'login.button-text': 'Bejelentkezés',
          'login.signup': 'Regisztráció',
          'login.welcome': 'Üdvözöllek!',
          'signup.title': 'Regisztráció',
          'signup.button-text': 'Regisztráció',
          'signup.login': 'bejelentkezés',
          'signup.username': 'felhasználónév',
          'signup.password-again': 'jelszó újra',
          'auth.forgot-password': 'Elfelejtett jelszó?',
          'auth.continue-anonymous': 'Folytatás fiók nélkül',
          'auth.email': 'email',
          'auth.password': 'jelszó',
          'validator.password-required': 'Adj meg egy jelszót',
          'validator.password-length': 'Legalább %s karakter',
          'validator.password-strength': 'Nem elég biztonságos',
          'validator.email': "Érvénytelen cím",
          'validator.email-required': "Adj meg egy email címet",
          'firebase.auth.invalid-email': "Érvénytelen email cím",
          "firebase.auth.user-disabled": "A felhasználó le van tiltva",
          "firebase.auth.wrong-password": "Hibás felhasználónév vagy jelszó",
          "firebase.auth.unknown-error": 'Ismeretlen hiba',
        },
        'en_AU': {
          ...flipMap(def),
          'meta.lang-name': 'au',
          "meta.lang-emoji": "🇦🇺"
        },
      };
}
