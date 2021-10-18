import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:report/api.dart';
import 'package:report/controller.dart';
import 'package:report/filter.dart';
import 'package:report/main.dart';
import 'package:report/multimedia-list.dart';
import 'package:report/programmer-list.dart';
import 'package:report/sales-counter-list.dart';
import 'package:report/sales-direct-llist.dart';
import 'package:report/user-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  final Controller controller = Get.put(Controller());
  final Controller find = Get.find();

  SharedPreferences sp;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    fromDate.text = DateFormat('dd MMM y').format(DateTime(2020, 10, 1)).toString();
    toDate.text = DateFormat('dd MMM y').format(DateTime.now()).toString();
  }

  @override
  void dispose() {
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
        title: Text('Report', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(() => UserPage());
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              child: ListView(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      if (find.isFilterActive.value == false) {
                        find.clearFilter();
                      }
                      showMaterialModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                        context: context,
                        builder: (context) => Filter(),
                      );
                    },
                    child: Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.tune),
                          SizedBox(width: 5),
                          Text("Filter"),
                        ],
                      ),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            if (find.filter.value.mainFilter == "Sales Direct")
              Expanded(
                child: find.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : SalesDirectReportList(
                        formModel: find.report.value,
                        mainFilter: find.filter.value.mainFilter,
                        salesDirect: find.filter.value.salesDirectType,
                        salesId: find.filter.value.salesId,
                      ),
              ),
            if (find.filter.value.mainFilter == "Sales Counter")
              Expanded(
                child: find.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : SalesCounterReportList(
                        formModel: find.report.value,
                        mainFilter: find.filter.value.mainFilter,
                        employeeId: find.filter.value.salesId,
                      ),
              ),
            if (find.filter.value.mainFilter == "Programmer")
              Expanded(
                child: find.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : ProgrammerReportList(
                        formModel: find.report.value,
                        mainFilter: find.filter.value.mainFilter,
                        employeeId: find.filter.value.salesId,
                      ),
              ),
            if (find.filter.value.mainFilter == "Multimedia")
              Expanded(
                child: find.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : MultimediaReportList(
                        formModel: find.report.value,
                        mainFilter: find.filter.value.mainFilter,
                        employeeId: find.filter.value.salesId,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
