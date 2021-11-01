import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/api.dart';
import 'package:report/calling-report-detail.dart';
import 'package:report/fee-report-detail.dart';
import 'package:report/visit-report-detail.dart';

import 'controller.dart';

class SalesDirectReportList extends StatefulWidget {
  @override
  _SalesDirectReportListState createState() => _SalesDirectReportListState();
}

class _SalesDirectReportListState extends State<SalesDirectReportList> {
  final controller = Get.find<Controller>();

  late ScrollController scrollController;
  late List<Data> report;
  int currentPage = 1;
  bool hasMore = false;
  final currency = NumberFormat.decimalPattern();

  Future<void> addMoreData() async {
    if (controller.mainFilter.value == "Sales Direct") {
      if (controller.salesDirectType.value == "Visit") {
        final data = await APIService().fetchVisitReport(
            page: currentPage + 1,
            userId: controller.salesId.value == 0 ? null : controller.salesId.value,
            fromDate: null,
            toDate: null);
        if (data.data!.isEmpty) {
          setState(() {
            hasMore = false;
          });
        } else {
          setState(() {
            currentPage++;
            hasMore = true;
            report.addAll(data.data!);
          });
        }
      }
      if (controller.salesDirectType.value == "Calling") {
        APIService()
            .fetchCallingReport(
          currentPage + 1,
          controller.salesId.value == 0 ? null : controller.salesId.value,
          null,
          null,
        )
            .then((value) {
          if (value.data!.isEmpty) {
            setState(() {
              hasMore = false;
            });
          } else {
            setState(() {
              currentPage++;
              hasMore = true;
              report.addAll(value.data!);
            });
          }
        });
      }
      if (controller.salesDirectType.value == "Biaya - Biaya") {
        APIService()
            .fetchFeeReport(
          currentPage + 1,
          controller.salesId.value == 0 ? null : controller.salesId.value,
          null,
          null,
        )
            .then((value) {
          if (value.data!.isEmpty) {
            setState(() {
              hasMore = false;
            });
          } else {
            setState(() {
              currentPage++;
              hasMore = true;
              report.addAll(value.data!);
            });
          }
        });
      }
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        addMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: APIService().fetchVisitReport(),
      builder: (context, AsyncSnapshot<FormModel> snapshot) {
        if (snapshot.hasData) {
          report = snapshot.data!.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Data ${report.length} / ${snapshot.data!.recordsFiltered}',
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: hasMore ? report.length + 1 : report.length,
                  itemBuilder: (context, index) {
                    if (index == report.length) {
                      return _buildProgressIndicator();
                    }
                    return InkWell(
                      onTap: () {
                        if (controller.salesDirectType.value == "Visit") {
                          Get.to(() => VisitReportDetail(), arguments: report[index]);
                        } else if (controller.salesDirectType.value == "Calling") {
                          Get.to(() => CallingReportDetail(), arguments: report[index]);
                        } else if (controller.salesDirectType.value == "Biaya - Biaya") {
                          Get.to(() => FeeReportDetail(), arguments: report[index]);
                        }
                      },
                      child: Card(
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
                                  Text(
                                    report[index].username!,
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(report[index].createdAt!, style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(thickness: 1),
                              SizedBox(height: 10),
                              if (controller.salesDirectType.value == "Visit")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Detail', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Kategori', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].category!, style: GoogleFonts.sourceSansPro()),
                                    SizedBox(height: 10),
                                    Text('Customer', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Nama', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].customer!, style: GoogleFonts.sourceSansPro()),
                                    SizedBox(height: 10),
                                    Text('Nomor Telfon', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].phoneNumber ?? '-', style: GoogleFonts.sourceSansPro()),
                                  ],
                                ),
                              if (controller.salesDirectType.value == "Calling")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Detail', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Kategori', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].category!, style: GoogleFonts.sourceSansPro()),
                                    SizedBox(height: 10),
                                    Text('Customer', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Nama', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].customer!, style: GoogleFonts.sourceSansPro()),
                                    SizedBox(height: 10),
                                    Text('Nomor Telfon', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].phoneNumber ?? '-', style: GoogleFonts.sourceSansPro()),
                                  ],
                                ),
                              if (controller.salesDirectType.value == "Biaya - Biaya")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Detail', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Kategori', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].category!, style: GoogleFonts.sourceSansPro()),
                                    SizedBox(height: 10),
                                    Text('Total', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text('Rp ${currency.format(report[index].total)}',
                                        style: GoogleFonts.sourceSansPro()),
                                    SizedBox(height: 10),
                                    Text('Goal', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                                    Text(report[index].goal!, style: GoogleFonts.sourceSansPro()),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return _buildProgressIndicator();
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
