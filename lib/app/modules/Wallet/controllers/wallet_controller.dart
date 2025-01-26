import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';

class WalletController extends GetxController {
  var selectedPage = 0.obs;
  UserController userController = Get.find<UserController>();
}
