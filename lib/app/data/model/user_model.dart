import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String? urlimage;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.urlimage});

  UserModel.fromFirebaseUser(User currentUser)
      : id = currentUser.uid,
        name = currentUser.displayName!,
        email = currentUser.email!,
        urlimage = currentUser.photoURL;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'urlimage': urlimage};
  }
}
