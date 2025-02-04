import 'package:child_community/util/key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController  extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = const Locale('en', 'US');
  bool _isLtr = true;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    if(_locale.languageCode == 'en') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }



  void toggleLanguage() {
    if(_locale.languageCode == 'en') {
      _locale = const Locale('bn', 'BD');
     // _isLtr = false;
    }else {
      _locale = const Locale('en', 'US');
      //_isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(ShareKey.languageCode) ?? 'en',
        sharedPreferences.getString(ShareKey.countryCode) ?? 'US');
   // _isLtr = _locale.languageCode == 'en';
    update();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(ShareKey.languageCode, locale.languageCode);
    sharedPreferences.setString(ShareKey.countryCode, locale.countryCode!);
  }

}