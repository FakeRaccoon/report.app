import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/Model/user-model.dart';

import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff516365),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<String> item = List.generate(10, (index) => "${index + 1}");
  TabController tabController;
  List<FormModel> report;
  int pageNumber = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Report',
            style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 65,
            child: ListView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.clear),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                                Text(
                                  'Jenis Laporan',
                                  style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding: EdgeInsets.zero,
                              title: Text('Sales Direct'),
                              onChanged: (value) {},
                              groupValue: 1,
                              value: 1,
                            ),
                            Divider(thickness: 1),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding: EdgeInsets.zero,
                              title: Text('Sales Counter'),
                              onChanged: (value) {},
                              groupValue: 1,
                              value: 2,
                            ),
                            Divider(thickness: 1),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding: EdgeInsets.zero,
                              title: Text('Programmer'),
                              onChanged: (value) {},
                              groupValue: 1,
                              value: 2,
                            ),
                            Divider(thickness: 1),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              contentPadding: EdgeInsets.zero,
                              title: Text('Multimedia'),
                              onChanged: (value) {},
                              groupValue: 1,
                              value: 2,
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: Get.width,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Terapkan'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffF3F8F2),
                      border: Border.all(width: 1, color: Color(0xff7F9D9D)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Sales Direct', style: TextStyle(color: Color(0xff7F9D9D))),
                            Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xff7F9D9D)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      useRootNavigator: true,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                      context: context,
                      builder: (BuildContext context) => Container(
                        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(Icons.clear),
                                    ),
                                    Text(
                                      'Pilih Sales',
                                      style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ],
                                ),
                                FutureBuilder<UserModel>(
                                  future: APIService().fetchUser(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.success.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          List<User> user = snapshot.data.success;
                                          return RadioListTile(
                                            controlAffinity: ListTileControlAffinity.trailing,
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(user[index].name),
                                            onChanged: (value) {},
                                            groupValue: -1,
                                            value: index,
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider(thickness: 1);
                                        },
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: Get.width,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Terapkan'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Semua Sales'),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Semua Tanggal'),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: APIService().fetchData(1, null),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ReportList(formModel: snapshot.data);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReportList extends StatefulWidget {
  final FormModel formModel;
  const ReportList({Key key, this.formModel}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  ScrollController scrollController = ScrollController();
  List<Datum> report;
  int currentPage = 1;
  bool hasMore = true;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        APIService().fetchData(currentPage + 1, null).then((value) {
          if (value.data.isEmpty) {
            setState(() {
              hasMore = false;
            });
          } else {
            setState(() {
              currentPage++;
              hasMore = true;
              report.addAll(value.data);
            });
          }
        });
      }
    });
    report = widget.formModel.data;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: hasMore ? report.length + 1 : report.length,
      itemBuilder: (context, index) {
        if (index >= report.length) {
          return _buildProgressIndicator();
        }
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(10),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report[index].username, style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                    Text(report[index].createdAt, style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(report[index].customer, style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                  subtitle: Text(report[index].category),
                  trailing: Text('Prospek'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }
}
