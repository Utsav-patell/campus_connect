import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../widgets/campus_connect_button.dart';
import '../../../widgets/campus_connect_text_field.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final CreatePostController _controller = Get.put(CreatePostController());

  final TextEditingController _contentController = TextEditingController();

  Future<void> _createPost() async {
    if (_contentController.text.trim().isEmpty) {
      return;
    }

    final success = await _controller.createPost(
      content: _contentController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Get.back();
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.createPost)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CampusConnectTextField(
                  controller: _contentController,
                  hintText: 'What do you want to share?',
                ),

                const SizedBox(height: 24),

                if (_controller.errorMessage.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(_controller.errorMessage.value),
                  ),

                CampusConnectButton(
                  text: AppStrings.createPost,
                  isLoading: _controller.isLoading.value,
                  onPressed: _createPost,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
