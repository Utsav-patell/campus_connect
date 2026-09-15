import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/campus_connect_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profile)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
            ),
          );
        }

        final user = controller.user.value;

        if (user == null) {
          return const Center(child: Text('User profile not found'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, size: 40, color: AppColors.white),
              ),
              const SizedBox(height: 24),
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user.email,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.grey),
              ),
              const SizedBox(height: 32),
              _ProfileInfo(label: AppStrings.name, value: user.name),
              const SizedBox(height: 16),
              _ProfileInfo(label: AppStrings.email, value: user.email),
              const SizedBox(height: 16),
              _ProfileInfo(label: AppStrings.college, value: user.college),
              const SizedBox(height: 32),
              CampusConnectButton(
                text: AppStrings.logout,
                onPressed: controller.logout,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
