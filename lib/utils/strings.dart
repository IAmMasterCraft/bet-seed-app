import 'dart:math';

import 'colors.dart';

const USERS = "users";

const THEME = 'theme';
const SETTINGS = 'settings';
const LANGUAGE_CODES = 'language_codes';

const STATUS = 'status';
const MESSAGE = 'message';
const DEFAULT_ERROR = "Something went wrong";

const CHARS = "abcdefghijklmnopqrstuvwxyz0123456789";

const EMAIL_REGEX =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String randomString(int strlen) {
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += CHARS[rnd.nextInt(CHARS.length)];
  }
  return result;
}

extension StringExtension on String? {
  String capitalize() {
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }
}

const ENGLISH = "english";
const FRENCH = "french";
const JAPANESE = "japanese";
const CHINESE = "chinese";
const HINDI = "hindi";
const RUSSIAN = "russian";
const KOREAN = "korean";
const BELGIUM = "belgium";
const GERMAN = "german";
const SPANISH = "spanish";
const PORTUGUESE = "portuguese";
const INDONESIAN = "indonesian";
const ARABIC = "arabic";

const List<String> LANGUAGECODES = [
  'ar',
  'de',
  'en',
  'es',
  'fr',
  'hi',
  'id',
  'ja',
  'ko',
  'nl',
  'pt',
  'ru',
  'zh',
];

const List<String?> LANGUAGES = [
  ARABIC,
  GERMAN,
  ENGLISH,
  SPANISH,
  FRENCH,
  HINDI,
  INDONESIAN,
  JAPANESE,
  KOREAN,
  BELGIUM,
  PORTUGUESE,
  RUSSIAN,
  CHINESE,
];

const SYSTEM = 'system';
const LIGHT = 'light';
const DARK = 'dark';

const List THEME_MODES = [
  SYSTEM,
  LIGHT,
  DARK,
];

const PENDING = 'Pending';
const WON = 'Won';
const LOST = 'Lost';

const List TIPSSTATUS = [
  LOST,
  PENDING,
  WON,
];

List statusColor = [
  red,
  amber,
  primaryColor,
];

const BRONZE = 'bronze';
const SILVER = 'silver';
const GOLD = 'gold';
const EMERALD = 'emerald';
const RUBY = 'ruby';
const DIAMOND = 'diamond';

const List<String> PACKAGES = [
  BRONZE,
  SILVER,
  GOLD,
  EMERALD,
  RUBY,
  DIAMOND,
];

const COIN_PER_SALE = 3000;
const SUCCESS_RATE = '92.0';
const ROI = '15.0';

const List<String> TIPS_SUBSCRIPTIONS = [
  'Coin',
  'One Day',
  'One Week',
  'One Month',
  'Three Months',
  'Six Months',
];

const List<String> INVESTMENT_SUBSCRIPTIONS = [
  'One Month',
  'Three Months',
  'Six Months',
];

const SPORTS_LIST = [
  'Football',
  'BasketBall',
  'VolleyBall',
  'Table Tennis',
  'Tennis',
  'Cricket',
  'Boxing',
  'Ice Hockey',
  'Rugby',
  'HandBall',
  'Snooker',
  'Futsal',
  'Darts',
  'Badminton',
];
