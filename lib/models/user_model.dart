class UserModel {
  final String uid;
  final String name;
  final String email;
  final String college;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.college,
  });

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'email': email, 'college': college};
  }
}
