import 'package:campus_connect/core/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/firestore_service.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final currentUser = _authService.currentUser;

      if (currentUser == null) {
        errorMessage.value = 'User is not logged in';
        return;
      }

      user.value = await _firestoreService.getUser(currentUser.uid);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
