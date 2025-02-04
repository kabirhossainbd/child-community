import 'dart:convert';
import 'package:child_community/common/data/datasource/remote/api_client.dart';
import 'package:child_community/core/data/model/language_model.dart';
import 'package:child_community/ui/view/home/controller/home_controller.dart';
import 'package:child_community/ui/view/home/data/repo/home_repo.dart';
import 'package:child_community/util/key.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/controller/localization_controller.dart';
import 'common/controller/theme_controller.dart';


Future<Map<String, Map<String, String>>> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //Core
  Get.lazyPut(() => ApiClient(appBaseUrl: ShareKey.baseUrl,  sharedPreferences: Get.find()));


  // Repo
  Get.lazyPut(() => HomeRepo(apiSource: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeController(homeRepo: Get.find()));

  /// read from json file
  Map<String, Map<String, String>> langFiles = {};
  for(LanguageModel languageModel in ShareKey.languages) {
    String jsonToString =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonToString);
    Map<String, String> convertToJson = {};
    mappedJson.forEach((key, value) {
      convertToJson[key] = value.toString();
    });
    langFiles['${languageModel.languageCode}_${languageModel.countryCode}'] = convertToJson;
  }
  return langFiles;
}
