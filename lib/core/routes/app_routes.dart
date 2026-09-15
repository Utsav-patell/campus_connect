import 'package:campus_connect/features/auth/views/signup_view.dart';
import 'package:campus_connect/features/create_post/views/create_post_view.dart';
import 'package:campus_connect/features/profile/views/profile_view.dart';
import 'package:get/get.dart';

import '../../features/auth/views/login_view.dart';
import '../../features/home/views/home_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String signup = '/signup';
  static const String createPost = '/create-post';
  static const String profile = '/profile';

  static final List<GetPage> pages = [
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: home, page: () => const HomeView()),
    GetPage(name: signup, page: () => const SignupView()),
    GetPage(name: createPost, page: () => const CreatePostView()),
    GetPage(name: profile, page: () => const ProfileView()),
  ];
}
