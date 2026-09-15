import 'package:campus_connect/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    final data = doc.data();

    if (data == null) {
      return null;
    }

    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      college: data['college'] ?? '',
    );
  }

  Future<List<PostModel>> getPosts() async {
    final snapshot = await _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return PostModel.fromMap(doc.id, doc.data());
    }).toList();
  }

  Future<void> createPost(PostModel post) async {
    await _firestore.collection('posts').add(post.toMap());
  }
}
