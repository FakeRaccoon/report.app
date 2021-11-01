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

import 'Model/form-model.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                      if (controller.isFilterActive.value == false) {
                        controller.clearFilter();
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
            if (controller.mainFilter.value == "Sales Direct") Expanded(child: SalesDirectReportList()),
            if (controller.mainFilter.value == "Sales Counter")
              Expanded(
                child: controller.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : SalesCounterReportList(
                        formModel: controller.report.value,
                        mainFilter: controller.mainFilter.value,
                        employeeId: controller.salesId.value,
                      ),
              ),
            if (controller.mainFilter.value == "Programmer")
              Expanded(
                child: controller.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : ProgrammerReportList(
                        formModel: controller.report.value,
                        mainFilter: controller.mainFilter.value,
                        employeeId: controller.salesId.value,
                      ),
              ),
            if (controller.mainFilter.value == "Multimedia")
              Expanded(
                child: controller.isLoading.value == true
                    ? Center(child: CircularProgressIndicator())
                    : MultimediaReportList(
                        formModel: controller.report.value,
                        mainFilter: controller.mainFilter.value,
                        employeeId: controller.salesId.value,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
