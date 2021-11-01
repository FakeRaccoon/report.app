import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:report/Model/sales-direct-detail-model.dart';
import 'package:report/api.dart';
import 'package:report/calling-report-detail.dart';

import 'Model/form-model.dart';

class VisitReportDetail extends StatelessWidget {
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
          'Detail Laporan Visit',
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
                      ReportDetailSubItems(header: 'Kategori', body: data.form!.category!),
                    ],
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Prospek',
                    items: [
                      SizedBox(height: 10),
                      Text(data.form!.prospect!, style: GoogleFonts.sourceSansPro()),
                    ],
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Informasi Laporan',
                    items: [
                      ReportDetailSubItems(header: 'Pembayaran', body: data.form!.payment),
                      ReportDetailSubItems(header: 'Leasing', body: data.form!.leasing),
                      ReportDetailSubItems(header: 'Deskripsi', body: data.form!.description),
                    ],
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Tanggal Kunjungan',
                    items: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Pertama', style: GoogleFonts.sourceSansPro()),
                          Spacer(),
                          if (data.form!.dateVisit!.i == null)
                            Icon(
                              Icons.clear,
                              color: Colors.red,
                            )
                          else
                            Text(DateFormat('d MMMM y').format(data.form!.dateVisit!.i!),
                                style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Kedua', style: GoogleFonts.sourceSansPro()),
                          Spacer(),
                          if (data.form!.dateVisit!.ii == null)
                            Icon(
                              Icons.clear,
                              color: Colors.red,
                            )
                          else
                            Text(DateFormat('d MMMM y').format(data.form!.dateVisit!.ii!),
                                style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Ketiga', style: GoogleFonts.sourceSansPro()),
                          Spacer(),
                          if (data.form!.dateVisit!.iii == null)
                            Icon(
                              Icons.clear,
                              color: Colors.red,
                            )
                          else
                            Text(DateFormat('d MMMM y').format(data.form!.dateVisit!.iii!),
                                style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Keempat', style: GoogleFonts.sourceSansPro()),
                          Spacer(),
                          if (data.form!.dateVisit!.iv == null)
                            Icon(
                              Icons.clear,
                              color: Colors.red,
                            )
                          else
                            Text(DateFormat('d MMMM y').format(data.form!.dateVisit!.iv!),
                                style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Kelima', style: GoogleFonts.sourceSansPro()),
                          Spacer(),
                          if (data.form!.dateVisit!.v == null)
                            Icon(
                              Icons.clear,
                              color: Colors.red,
                            )
                          else
                            Text(DateFormat('d MMMM y').format(data.form!.dateVisit!.v!),
                                style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Informasi Customer',
                    items: [
                      ReportDetailSubItems(header: 'Nama', body: data.form!.customer!.name),
                      ReportDetailSubItems(header: 'Nomor Telfon', body: data.form!.customer!.phone),
                      ReportDetailSubItems(header: 'Email', body: data.form!.customer!.email),
                      ReportDetailSubItems(header: 'Pekerjaan', body: data.form!.customer!.job),
                      ReportDetailSubItems(header: 'Latar Belakang', body: data.form!.customer!.background),
                      ReportDetailSubItems(
                        header: 'Domisili',
                        body:
                            '${data.form!.customer!.province}, ${data.form!.customer!.city}, ${data.form!.customer!.district == data.form!.customer!.city ? '' : ', ' + data.form!.customer!.district!}${data.form!.customer!.village == data.form!.customer!.district ? '' : ', ' + data.form!.customer!.village!}',
                      ),
                      data.form!.customer!.address == data.form!.customer!.village
                          ? SizedBox()
                          : ReportDetailSubItems(
                              header: 'Alamat',
                              body: data.form!.customer!.address,
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
