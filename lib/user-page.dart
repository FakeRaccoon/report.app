import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report/api.dart';
import 'package:report/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late SharedPreferences sp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'User Page',
          style: GoogleFonts.sourceSansPro(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () async {
                  APIService().logout().then((value) async {
                    if (value == 200) {
                      sp = await SharedPreferences.getInstance();
                      sp.clear();
                      Get.offAll(() => Root());
                    }
                  });
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
