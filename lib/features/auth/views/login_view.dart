import 'package:campus_connect/core/constants/app_colors.dart';
import 'package:campus_connect/core/routes/app_routes.dart';
import 'package:campus_connect/widgets/campus_connect_button.dart';
import 'package:campus_connect/widgets/campus_connect_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';

import '../controllers/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final success = await _authController.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GetBuilder<AuthController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      AppStrings.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      AppStrings.connectWithCampus,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    CampusConnectTextField(
                      controller: _emailController,
                      hintText: AppStrings.email,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    CampusConnectTextField(
                      controller: _passwordController,
                      hintText: AppStrings.password,
                      obscureText: true,
                    ),

                    if (controller.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          controller.errorMessage!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(color: AppColors.red),
                        ),
                      ),
                    const SizedBox(height: 24),
                    CampusConnectButton(
                      text: AppStrings.login,
                      isLoading: controller.isLoading,
                      onPressed: _login,
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: const Text(AppStrings.dontHaveAccount),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
