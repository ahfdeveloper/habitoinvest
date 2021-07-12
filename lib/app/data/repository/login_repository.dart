import 'package:habito_invest_app/app/data/model/user_model.dart';
import 'package:habito_invest_app/app/data/provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider = LoginProvider();

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password, String name) {
    return loginProvider.createUserWithEmailAndPassword(email, password, name);
  }

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) {
    return loginProvider.signInWithEmailAndPassword(email, password);
  }

  Future<UserModel?> signInWithGoogle() {
    return loginProvider.signInWithGoogle();
  }

  signOut() {
    loginProvider.signOut();
  }
}
