import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/post_model.dart';
import '../../../services/firestore_service.dart';

class CreatePostController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> createPost({required String content}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        errorMessage.value = 'User is not logged in';
        return false;
      }

      final userData = await _firestoreService.getUser(user.uid);

      if (userData == null) {
        errorMessage.value = 'User profile not found';
        return false;
      }

      final post = PostModel(
        id: '',
        userId: user.uid,
        userName: userData.name,
        content: content,
        imageUrl: null,
        createdAt: DateTime.now(),
      );

      await _firestoreService.createPost(post);

      return true;
    } catch (error) {
      errorMessage.value = error.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
