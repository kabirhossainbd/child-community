import 'package:child_community/core/data/model/language_model.dart';

class ShareKey {

  static const String baseUrl = '';
  static const String appName = 'Child Community';
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
  ];
}