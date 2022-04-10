import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider = LoginProvider();

  Future<UserModel?> createUserWithEmailAndPassword(
      {required String email, required String password, required String name}) {
    return loginProvider.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
  }

  Future addUserFirestore(
      {required String userUid,
      required String name,
      required String email}) async {
    return loginProvider.addUserFirestore(
      userUid: userUid,
      name: name,
      email: email,
    );
  }

  Future<UserModel?> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return loginProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserModel?> signInWithGoogle() {
    return loginProvider.signInWithGoogle();
  }

  verifyUserInBD(
      {required String userUid, required String name, required String email}) {
    return loginProvider.verifyUserInBD(
      userUid: userUid,
      name: name,
      email: email,
    );
  }

  signOut() {
    loginProvider.signOut();
  }
}
