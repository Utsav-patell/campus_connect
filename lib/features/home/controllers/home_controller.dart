import 'package:get/get.dart';

import '../../../models/post_model.dart';
import '../../../services/firestore_service.dart';

class HomeController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<PostModel> posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future<void> getPosts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      posts.value = await _firestoreService.getPosts();
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
