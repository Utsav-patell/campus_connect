import 'package:campus_connect/features/auth/views/signup_view.dart';
import 'package:get/get.dart';

import '../../features/auth/views/login_view.dart';
import '../../features/home/views/home_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static String signup = '/signup';

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: home, page: () => const HomeView()),
    GetPage(name: signup, page: () => const SignupView()),
  ];
}
