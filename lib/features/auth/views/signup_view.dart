import 'package:campus_connect/core/constants/app_strings.dart';
import 'package:campus_connect/core/routes/app_routes.dart';
import 'package:campus_connect/widgets/campus_connect_button.dart';
import 'package:campus_connect/widgets/campus_connect_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    final success = await _authController.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
      college: _collegeController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _collegeController.dispose();
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
                      AppStrings.signUp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 32),

                    CampusConnectTextField(
                      controller: _nameController,
                      hintText: AppStrings.name,
                    ),

                    const SizedBox(height: 16),

                    CampusConnectTextField(
                      controller: _emailController,
                      hintText: AppStrings.email,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    CampusConnectTextField(
                      controller: _collegeController,
                      hintText: AppStrings.college,
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
                        ),
                      ),

                    const SizedBox(height: 24),

                    CampusConnectButton(
                      text: AppStrings.signUp,
                      isLoading: controller.isLoading,
                      onPressed: _signUp,
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.login);
                      },
                      child: const Text('Already have an account? Login'),
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
