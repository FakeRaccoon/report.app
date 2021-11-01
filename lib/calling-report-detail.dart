import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/Model/sales-direct-detail-model.dart';
import 'package:report/api.dart';

class CallingReportDetail extends StatefulWidget {
  const CallingReportDetail({Key? key}) : super(key: key);

  @override
  _CallingReportDetailState createState() => _CallingReportDetailState();
}

class _CallingReportDetailState extends State<CallingReportDetail> {
  Data report = Get.arguments;
  late SalesDirectDetailModel data;
  var currency = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Detail Laporan Calling',
          style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<SalesDirectDetailModel>(
        future: APIService().fetchSalesDirectReportDetail(report.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Detail',
                    items: [
                      ReportDetailSubItems(
                        header: 'Sales',
                        body: data.username,
                      ),
                      ReportDetailSubItems(
                        header: 'Kategori',
                        body: data.form!.category,
                      ),
                      ReportDetailSubItems(
                        header: 'Prospek',
                        body: data.form!.prospect,
                      ),
                      ReportDetailSubItems(
                        header: 'Alasan',
                        body: data.form!.reasonCall,
                      ),
                      ReportDetailSubItems(
                        header: 'Permisuman Pertanian',
                        body: data.form!.agriculturalSeason,
                      ),
                      ReportDetailSubItems(
                        header: 'Harga Serwa',
                        body: 'Rp ${currency.format(int.parse(data.form!.rentalPrice!))}',
                      ),
                      ReportDetailSubItems(
                        header: 'Masalah Mesin',
                        body: data.form!.engineProblem,
                      ),
                      ReportDetailSubItems(
                        header: 'Kinerja',
                        body: data.form!.performance,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                              if (data.form!.ownership!.yanmar == null)
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              else
                                Text(data.form!.ownership!.yanmar!, style: GoogleFonts.sourceSansPro()),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Kubota', style: GoogleFonts.sourceSansPro()),
                              Spacer(),
                              if (data.form!.ownership!.kubota == null)
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              else
                                Text(data.form!.ownership!.kubota!, style: GoogleFonts.sourceSansPro()),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('China', style: GoogleFonts.sourceSansPro()),
                              Spacer(),
                              if (data.form!.ownership!.china == null)
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              else
                                Text(data.form!.ownership!.china!, style: GoogleFonts.sourceSansPro()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ReportDetailItems(
                    data: data,
                    currency: currency,
                    title: 'Informasi Customer',
                    items: [
                      ReportDetailSubItems(
                        header: 'Nama',
                        body: data.form!.customer!.name,
                      ),
                      ReportDetailSubItems(
                        header: 'Nomor Telfon',
                        body: data.form!.customer!.phone,
                      ),
                      ReportDetailSubItems(
                        header: 'Email',
                        body: data.form!.customer!.email ?? '-',
                      ),
                      ReportDetailSubItems(
                        header: 'Pekerjaan',
                        body: data.form!.customer!.job,
                      ),
                      ReportDetailSubItems(
                        header: 'Latar Belakang',
                        body: data.form!.customer!.background,
                      ),
                      ReportDetailSubItems(
                        header: 'Domisili',
                        body:
                            '${data.form!.customer!.province! + ', '}${data.form!.customer!.city}${data.form!.customer!.district == data.form!.customer!.city ? '' : ', ' + data.form!.customer!.district!}${data.form!.customer!.village == data.form!.customer!.district ? '' : ', ' + data.form!.customer!.village!}',
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

class ReportDetailItems extends StatelessWidget {
  const ReportDetailItems({
    required this.data,
    required this.currency,
    required this.title,
    required this.items,
  });

  final SalesDirectDetailModel data;
  final NumberFormat currency;
  final String title;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 17)),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: items,
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailSubItems extends StatelessWidget {
  const ReportDetailSubItems({
    required this.header,
    this.body,
  });

  final String header;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(header, style: GoogleFonts.sourceSansPro(color: Colors.grey)),
        body == null ? SizedBox() : Text(body!, style: GoogleFonts.sourceSansPro()),
      ],
    );
  }
}
