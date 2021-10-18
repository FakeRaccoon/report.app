import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/api.dart';
import 'package:report/report-detail-model.dart';

class ReportDetail extends StatefulWidget {
  const ReportDetail({Key key}) : super(key: key);

  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  Datum report = Get.arguments;
  ReportDetailModel data;
  var currency = NumberFormat.decimalPattern();

  @override
  void initState() {
    super.initState();
    APIService().fetchReportDetail(report.id).then((value) {
      setState(() {
        data = value;
      });
    });
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Report Detail',
          style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Laporan Calling',
                              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 17)),
                          SizedBox(
                            height: 10,
                            width: Get.width,
                          ),
                          Text('Sales', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.username, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Kategori', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.category, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Prospek', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.prospect, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Alasan', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.reasonCall, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Permusiman Pertanian', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.agriculturalSeason, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Harga Sewa', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text('Rp ${currency.format(int.tryParse(data.form.rentalPrice))}', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Masalah Mesin', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.engineProblem, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Kinerja', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.performance, style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kepemilikan Unit',
                              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 17)),
                          SizedBox(
                            height: 10,
                            width: Get.width,
                          ),
                          Row(
                            children: [
                              Text('Yanmar', style: GoogleFonts.sourceSansPro()),
                              Spacer(),
                              if (data.form.ownership.yanmar == null)
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              else
                                Text(data.form.ownership.yanmar, style: GoogleFonts.sourceSansPro()),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Kubota', style: GoogleFonts.sourceSansPro()),
                              Spacer(),
                              if (data.form.ownership.kubota == null)
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              else
                                Text(data.form.ownership.kubota, style: GoogleFonts.sourceSansPro()),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('China', style: GoogleFonts.sourceSansPro()),
                              Spacer(),
                              if (data.form.ownership.china == null)
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              else
                                Text(data.form.ownership.china, style: GoogleFonts.sourceSansPro()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer Info',
                              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 17)),
                          SizedBox(
                            height: 10,
                            width: Get.width,
                          ),
                          Text('Nama', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.name ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Nomor Telfon', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.phone ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Email', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.email ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Pekerjaan', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.job ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Latar Belakang', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.background ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Provinsi', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.province ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Kota', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.city ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Kecamatan', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.district ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Kelurahan', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.village ?? '-', style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Alamat', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(data.form.customer.address ?? '-', style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
