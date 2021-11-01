import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:report/Model/sales-direct-detail-model.dart';
import 'package:report/api.dart';
import 'package:report/calling-report-detail.dart';
import 'package:report/style.dart';

import 'Model/form-model.dart';

class FeeReportDetail extends StatelessWidget {
  final Data data = Get.arguments;
  final NumberFormat currency = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Detail Laporan Biaya',
          style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: APIService().fetchSalesDirectReportDetail(data.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            SalesDirectDetailModel data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Detail',
                    items: [
                      ReportDetailSubItems(header: 'Sales', body: data.username),
                      ReportDetailSubItems(header: 'Kategori', body: data.form!.category),
                    ],
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Perincian Biaya Dinas',
                    items: [
                      ReportDetailSubItems(header: 'Tujuan', body: data.form!.goal),
                      ReportDetailSubItems(header: 'Kebutuhan', body: data.form!.need),
                      ReportDetailSubItems(
                        header: 'Tanggal Berangkat',
                        body: DateFormat('d MMMM y').format(data.form!.formIn!),
                      ),
                      ReportDetailSubItems(
                        header: 'Tanggal Kembali',
                        body: DateFormat('d MMMM y').format(data.form!.out!),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Detail Biaya',
                    items: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.form!.detail!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              data.form!.detail![index].description!,
                              style: AppStyle.bodyStyle,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
