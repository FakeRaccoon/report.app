import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report/api.dart';
import 'package:report/controller.dart';
import 'package:report/main.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final Controller controller = Get.find<Controller>();

  List<String> reportType = ["Sales Direct", "Sales Counter", "Programmer", "Multimedia"];
  List<String> salesDirectType = ["Visit", "Calling", "Biaya - Biaya"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Filter', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 18)),
                // Spacer(),
                // TextButton(
                //     style: TextButton.styleFrom(primary: Color(0xff363946)),
                //     onPressed: () {
                //       setState(() {
                //         controller.clearFilter();
                //         controller.isFilterActive.value = false;
                //         controller.checkDataCount();
                //       });
                //     },
                //     child: Text('Reset', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16))),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jenis Laporan', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
                  mainFilterContent(),
                ],
              ),
            ),
            Visibility(
              visible: controller.mainFilter.value != "Sales Direct" ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Laporan Sales Direct',
                        style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
                    salesDirectFilter(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.mainFilter.value != "Sales Direct" ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sales', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
                    salesFilter(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.mainFilter.value != "Sales Counter" ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Karyawan', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
                    salesFilter(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.mainFilter.value != "Programmer" ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Karyawan', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
                    salesFilter(),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.mainFilter.value != "Multimedia" ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Karyawan', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
                    salesFilter(),
                  ],
                ),
              ),
            ),
            // Text('Tanggal', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold, fontSize: 16)),
            // if (find.isFilterActive.value = false)
            SizedBox(
              width: Get.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff363946), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  controller.addFilter();
                  controller.isFilterActive.value = true;
                  Get.back();
                },
                child: controller.filterLoading.value == true
                    ? _buildProgressIndicator()
                    : Text('Tampilkan ${controller.filterCount.value} Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new SizedBox(
      height: 24,
      width: 24,
      child: new CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget salesFilter() {
    return Obx(() => Wrap(
        children: controller.sales
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    controller.salesName.value = e['name'];
                    controller.salesId.value = e['id'];
                    controller.checkDataCount();
                  },
                  child: Chip(
                      label: Text(e['name'],
                          style: TextStyle(
                              color: e['id'] == controller.salesId.value ? Colors.white : Colors.black)),
                      side: BorderSide(
                          color: e['id'] == controller.salesId.value ? Color(0xff363946) : Colors.grey),
                      backgroundColor:
                          e['id'] == controller.salesId.value ? Color(0xff363946) : Colors.transparent),
                ),
              ),
            )
            .toList()));
  }

  Widget salesDirectFilter() {
    return Wrap(
        children: salesDirectType
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      controller.salesDirectType.value = e;
                      controller.checkDataCount();
                    });
                  },
                  child: Chip(
                      label: Text(
                        e,
                        style: TextStyle(
                          color: e == controller.salesDirectType.value ? Colors.white : Colors.black,
                        ),
                      ),
                      side: BorderSide(
                          color: e == controller.salesDirectType.value ? Color(0xff363946) : Colors.grey),
                      backgroundColor:
                          e == controller.salesDirectType.value ? Color(0xff363946) : Colors.transparent),
                ),
              ),
            )
            .toList());
  }

  Wrap mainFilterContent() {
    return Wrap(
        children: reportType
            .map((e) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      controller.mainFilter.value = e;
                      controller.salesId.value = 0;
                      controller.fetchSales();
                      controller.checkDataCount();
                    });
                  },
                  child: Chip(
                      label: Text(e,
                          style:
                              TextStyle(color: e.contains(controller.mainFilter.value) ? Colors.white : Colors.black)),
                      side:
                          BorderSide(color: e.contains(controller.mainFilter.value) ? Color(0xff363946) : Colors.grey),
                      backgroundColor:
                          e.contains(controller.mainFilter.value) ? Color(0xff363946) : Colors.transparent),
                )))
            .toList());
  }
}
