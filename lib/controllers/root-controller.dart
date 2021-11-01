import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api.dart';
import '../home-page.dart';
import '../login.dart';

class RootController extends GetxController {
  final box = GetStorage();
  void checkLoginStatus() async {
    if (box.read('token') == null) {
      Get.offAll(() => LoginPage());
    } else {
      try {
        await APIService().fetchUserDetail();
        Get.offAll(() => HomePage());
      } catch (e) {
        Get.offAll(() => LoginPage());
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
}
