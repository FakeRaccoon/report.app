import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report/api.dart';
import 'package:report/controllers/root-controller.dart';
import 'package:report/home-page.dart';
import 'package:report/login.dart';
import 'package:report/style.dart';

import 'Model/login-detail-model.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(behavior: MyBehavior(), child: child!);
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: kPrimary),
        primaryColor: Color(0xff516365),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconTheme: IconThemeData(color: kPrimary),
      ),
      home: Root(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: APIService().fetchUserDetail(),
        builder: (BuildContext context, AsyncSnapshot<LoginDetail> snapshot) {
          if (snapshot.hasData) return HomePage();
          if (snapshot.hasError) return LoginPage();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Report App', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
