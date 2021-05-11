import 'package:get/get.dart';
import 'package:habito_invest_app/app/data/model/user_model.dart';

class HomeController extends GetxController {
  final UserModel? user = Get.arguments;
  RxInt _currentIndex = 0.obs;
  
  // Setter e Getter para variável currentIndex, para que a responsabilidade pela
  // alteração dos estados fique sob responsabilidade do controller
  get currentIndex => this._currentIndex.value;
  set currentIndex(value) => this._currentIndex.value = value;

  void changePage(int index) async{
    currentIndex = index;
  }

}