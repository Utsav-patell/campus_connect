import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../controllers/home_controller.dart';
import '../widgets/post_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          Obx(
            () => IconButton(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.getPosts,
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
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

        if (controller.posts.isEmpty) {
          return const Center(child: Text('No posts yet'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: controller.posts[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createPost);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
