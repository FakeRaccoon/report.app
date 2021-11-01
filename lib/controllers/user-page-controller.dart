import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../api.dart';
import '../login.dart';

class UserPageController extends GetxController {
  final box = GetStorage();
  void logout() async {
    await APIService().logout();
    await box.erase();
    Get.offAll(() => LoginPage());
  }
}
