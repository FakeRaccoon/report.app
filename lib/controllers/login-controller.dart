import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:report/home-page.dart';

import '../api.dart';

class LoginController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController passController;

  void login(BuildContext context) async {
    try {
      await APIService().login(usernameController.text, passController.text);
      Get.offAll(() => HomePage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login gagal'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passController.dispose();
  }
}
