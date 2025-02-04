
import 'package:child_community/ui/view/auth/login_screen.dart';
import 'package:child_community/ui/view/dashboard/dashboard_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouterHelper {
  static const String main = '/';
  static const String loginScreen = '/loginScreen';

  static String getMainRoute() => main;

  static List<GetPage> routes = [
    GetPage(name: main, page: () => const DashboardScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen())
  ];
}