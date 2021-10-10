import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';

class LoginProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GetStorage box = GetStorage('habito_invest_app');
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Retorna usuário logado
  Stream<UserModel> get authStateChanged => _firebaseAuth
      .authStateChanges()
      .map((User? currentUser) => UserModel.fromFirebaseUser(currentUser!));

  // Cria usuário com e-mail e senha
  Future<UserModel?> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    User user;
    try {
      final userCredential = (await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password));
      user = userCredential.user!;
      await user.updateDisplayName(name);
      await user.reload();
      user = _firebaseAuth.currentUser!;
      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      callError(e);
      return null;
    }
  }

  // Login do usuário com e-mail e senha
  Future<UserModel?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final currentUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      return UserModel.fromFirebaseUser(currentUser);
    } catch (e) {
      callError(e);
      return null;
    }
  }

  // Login social do usuário com a conta do Google
  Future<UserModel?> signInWithGoogle() async {
    try {
      final response = await _googleSignIn.signIn();
      final currentUser = UserModel(
        id: response!.id,
        name: response.displayName!,
        email: response.email,
        urlimage: response.photoUrl,
      );
      return currentUser;
    } catch (e) {
      callError(e);
      return null;
    }
  }

  // Adiciona o id do usuário como documento dentro da coleção 'users' do Firestore
  Future addUserFirestore(
      {required String userUid,
      required String name,
      required String email}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userUid)
          .set({'name': name, 'email': email});
    } catch (e) {
      callError(e);
      return null;
    }
  }

  /* Verifica a existência de usuário Google no BD. Caso o retorno seja negativo,
  chama a função que efetua seu registro. */
  Future verifyUserInBD(
      {required String userUid,
      required String name,
      required String email}) async {
    try {
      _firebaseFirestore.collection('users').doc(userUid).get().then((value) =>
          !value.exists
              ? addUserFirestore(userUid: userUid, name: name, email: email)
              : print('Usuário já cadastrado'));
    } catch (e) {
      callError(e);
      return null;
    }
  }

  // Logoff do usuário
  signOut() {
    box.write('auth', null);
    _googleSignIn.signOut();
    _firebaseAuth.signOut();
  }

  // Função chamada para exibição das mensagens de erro ao efetuar cadastro ou login de usuário.
  void callError(dynamic errorCode) {
    print(errorCode.code);
    Get.back();
    switch (errorCode.code) {
      case 'user-not-found':
        Get.defaultDialog(
            title: 'ATENÇÃO', content: Text('Usuário não encontrado'));
        break;
      case 'wrong-password':
        Get.defaultDialog(
            title: 'ATENÇÃO',
            content: Text('Senha não confere com o cadastro'));
        break;
      case 'user-disabled':
        Get.defaultDialog(
            title: 'ATENÇÃO', content: Text('Este usuário foi desativado'));
        break;
      case 'too-many-requests':
        Get.defaultDialog(
            title: 'ATENÇÃO',
            content: Text(
                'Muitas tentativas de acesso. Tente novamente mais tarde'));
        break;
      case 'operation-not-allowed':
        Get.defaultDialog(
            title: 'ATENÇÃO', content: Text('Login não permitido'));
        break;
      case 'email-already-in-use':
        Get.defaultDialog(
            title: 'ATENÇÃO', content: Text('Este e-mail já está em uso'));
        break;
      case 'weak-password':
        Get.defaultDialog(
            title: 'ATENÇÃO',
            content: Text('Senha deve possuir, no mínimo, 6 caracteres'));
        break;
      case 'invalid-email':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('E-mail inválido'));
        break;

      default:
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('$errorCode'));
        break;
    }
  }
}
