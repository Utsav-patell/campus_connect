import 'package:campus_connect/models/user_model.dart';
import 'package:campus_connect/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  bool isLoading = false;
  String? errorMessage;

  Future<bool> signUp({
    required String name,
    required String email,
    required String college,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      final credential = await _authService.signUp(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        college: college,
      );

      await _firestoreService.createUser(user);

      return true;
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message;
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      await _authService.login(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message;
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  User? get currentUser => _authService.currentUser;
}
