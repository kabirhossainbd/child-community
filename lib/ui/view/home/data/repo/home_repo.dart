import 'package:child_community/common/data/datasource/remote/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  final ApiClient apiSource;
  final SharedPreferences sharedPreferences;
  HomeRepo({required this.apiSource, required this.sharedPreferences});

}
