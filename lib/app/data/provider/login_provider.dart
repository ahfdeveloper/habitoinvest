import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class LoginProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GetStorage box = GetStorage('habito_invest_app');
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Retorna usuário logado
  Stream<UserModel> get authStateChanged => _firebaseAuth.authStateChanges().map((User? currentUser) => UserModel.fromFirebaseUser(currentUser!));

  // Cria usuário com e-mail e senha
  Future<UserModel?> createUserWithEmailAndPassword({required String email, required String password, required String name}) async {
    User user;
    try {
      final userCredential = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password));
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
  Future<UserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
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
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential _authResult = await _firebaseAuth.signInWithCredential(credential);

      final currentUser = UserModel(
        id: _authResult.user!.uid,
        name: _authResult.user!.displayName!,
        email: _authResult.user!.email!,
        urlimage: _authResult.user!.photoURL,
      );
      return currentUser;
    } catch (e) {
      callError(e);
      return null;
    }
  }

  /* Verifica a existência de usuário Google no BD. Caso o retorno seja negativo,
  chama a função que efetua seu registro no Firebase. */
  Future<void> verifyUserInBD({required String userUid, required String name, required String email}) async {
    try {
      _firebaseFirestore.collection('users').doc(userUid).get().then((value) {
        if (!value.exists) {
          addUserFirestore(userUid: userUid, name: name, email: email);
        }
      });
    } catch (e) {
      callError(e);
      return null;
    }
  }

  // Adiciona o id do usuário como documento dentro da coleção 'users' do Firestore
  Future<void> addUserFirestore({required String userUid, required String name, required String email}) async {
    try {
      await _firebaseFirestore.collection('users').doc(userUid).set({'name': name, 'email': email, 'id': userUid});
    } catch (e) {
      callError(e);
      return null;
    }
  }

  // Adiciona uma conta para controle de saldo para usuário Google recém registrado no banco
  Future<void> addAccount({
    required String userUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('account').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'accBalance': 0,
      'accValueLT': 0,
      'accTypeLT': 'Inicio',
      'accDateLT': DateTime.now(),
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Quando usuário não possui metas cadastradas adiciona valor default zero para que o mesmo atualize
  Future<void> addGoal({
    required String userUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('goals').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'gDate': DateTime.now(),
      'gPercentageInvestment': 0,
      'gPercentageNotEssentialExpenses': 0,
      'gValueInvestment': 0,
      'gValueNotEssentialExpenses': 0,
    };

    await documentReference.set(data).catchError((e) => print(e));
  }

  // Quando usuário se registra a função adiciona valores padrões aos seus parâmetros
  Future<void> addParameter({
    required String userUid,
  }) async {
    DocumentReference documentReference = _firebaseFirestore.doc(userUid).collection('parameter').doc();

    Map<String, dynamic> data = <String, dynamic>{
      'parDate': DateTime.now(),
      'parDayInitialPeriod': 1,
      'parSalary': 0,
      'parWorkedHours': 0,
    };
    await documentReference.set(data).catchError((e) => print(e));
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
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Usuário não encontrado'));
        break;
      case 'wrong-password':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Senha não confere com o cadastro'));
        break;
      case 'user-disabled':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Este usuário foi desativado'));
        break;
      case 'too-many-requests':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Muitas tentativas de acesso. Tente novamente mais tarde'));
        break;
      case 'operation-not-allowed':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Login não permitido'));
        break;
      case 'email-already-in-use':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Este e-mail já está em uso'));
        break;
      case 'weak-password':
        Get.defaultDialog(title: 'ATENÇÃO', content: Text('Senha deve possuir, no mínimo, 6 caracteres'));
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
