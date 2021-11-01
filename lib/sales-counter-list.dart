import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/api.dart';

class SalesCounterReportList extends StatefulWidget {
  final FormModel? formModel;
  final int? employeeId;
  final String? mainFilter;
  final DateTime? fromDate;
  final DateTime? toDate;
  const SalesCounterReportList({
    this.formModel,
    this.employeeId,
    this.mainFilter,
    this.fromDate,
    this.toDate,
  });

  @override
  _SalesCounterReportListState createState() => _SalesCounterReportListState();
}

class _SalesCounterReportListState extends State<SalesCounterReportList> {
  late ScrollController scrollController;
  List<Data>? report;
  int currentPage = 1;
  bool hasMore = false;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        APIService()
            .fetchSalesCounterReport(
          currentPage + 1,
          widget.employeeId == 0 ? null : widget.employeeId,
          widget.fromDate,
          widget.toDate,
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
              report!.addAll(value.data!);
            });
          }
        });
      }
    });
    report = widget.formModel!.data!;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Data ${report!.length} / ${widget.formModel!.recordsFiltered}',
              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: hasMore ? report!.length + 1 : report!.length,
            itemBuilder: (context, index) {
              if (index == report!.length) {
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
                          Text(report![index].username!, style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                          Text(report![index].createdAt!, style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Detail', style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('Kontak', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(report![index].contact!, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Problem', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(report![index].problem!, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Solution', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(report![index].solution!, style: GoogleFonts.sourceSansPro()),
                          SizedBox(height: 10),
                          Text('Type', style: GoogleFonts.sourceSansPro(color: Colors.grey)),
                          Text(report![index].type!, style: GoogleFonts.sourceSansPro()),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
