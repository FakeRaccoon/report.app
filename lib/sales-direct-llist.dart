import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/http/io/file_decoder_io.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/api.dart';

class SalesDirectReportList extends StatefulWidget {
  final FormModel formModel;
  final int salesId;
  final String mainFilter;
  final String salesDirect;
  final DateTime fromDate;
  final DateTime toDate;
  const SalesDirectReportList({
    Key key,
    this.salesId,
    this.formModel,
    this.mainFilter,
    this.salesDirect,
    this.fromDate,
    this.toDate,
  }) : super(key: key);

  @override
  _SalesDirectReportListState createState() => _SalesDirectReportListState();
}

class _SalesDirectReportListState extends State<SalesDirectReportList> {
  ScrollController scrollController = ScrollController();
  List<Datum> report;
  int currentPage = 1;
  bool hasMore = false;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (widget.mainFilter == "Sales Direct") {
          if (widget.salesDirect == "Visit") {
            APIService()
                .fetchVisitReport(
              currentPage + 1,
              widget.salesId == 0 ? null : widget.salesId,
              widget.fromDate,
              widget.toDate,
            )
                .then((value) {
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
          } else if (widget.salesDirect == "Calling") {
            APIService()
                .fetchCallingReport(
              currentPage + 1,
              widget.salesId == 0 ? null : widget.salesId,
              widget.fromDate,
              widget.toDate,
            )
                .then((value) {
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
          } else if (widget.salesDirect == "Biaya - Biaya") {
            APIService()
                .fetchFeeReport(
              currentPage + 1,
              widget.salesId == 0 ? null : widget.salesId,
              widget.fromDate,
              widget.toDate,
            )
                .then((value) {
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
        }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Data ${report.length} / ${widget.formModel.recordsFiltered}',
              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
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
                      if (widget.salesDirect == "Visit" || widget.salesDirect == "Calling")
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(report[index].customer,
                              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                          subtitle: Text(report[index].category),
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

class SalesCounterReportList extends StatefulWidget {
  final FormModel formModel;
  final int employeeId;
  final String mainFilter;
  final DateTime fromDate;
  final DateTime toDate;
  const SalesCounterReportList({
    Key key,
    this.formModel,
    this.employeeId,
    this.mainFilter,
    this.fromDate,
    this.toDate,
  }) : super(key: key);

  @override
  _SalesCounterReportListState createState() => _SalesCounterReportListState();
}

class _SalesCounterReportListState extends State<SalesCounterReportList> {
  ScrollController scrollController = ScrollController();
  List<Datum> report;
  int currentPage = 1;
  bool hasMore = false;

  @override
  void initState() {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Data ${report.length} / ${widget.formModel.recordsFiltered}',
              style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
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
                        title:
                            Text(report[index].problem, style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold)),
                        subtitle: Text(report[index].solution),
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
