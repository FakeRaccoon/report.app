import 'dart:ffi';

import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/Model/user-model.dart';
import 'package:report/api.dart';

class Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    addFilter();
    fetchSales();
    checkDataCount();
  }

  var mainFilter = 'Sales Direct'.obs;
  var salesDirectType = "Visit".obs;
  var salesName = "Semua Sales".obs;
  var salesId = 0.obs;
  var isFilterActive = false.obs;
  var report = FormModel().obs;
  var items = Data().obs;
  var sales = [].obs;
  var isLoading = true.obs;
  var filterLoading = true.obs;
  var filterCount = 0.obs;

  void fetchSales() async {
    sales.clear();
    sales.add({"id": 0, "name": "Semua Karyawan"});
    if (mainFilter.value == "Sales Direct") {
      final value = await APIService().fetchSalesUserDirect();
      value.success!.forEach((element) {
        sales.add({"id": element.id, "name": element.name});
      });
    }
    if (mainFilter.value == "Sales Counter") {
      final value = await APIService().fetchUserCounter();
      value.success!.forEach((element) {
        sales.add({"id": element.id, "name": element.name});
      });
    }
    if (mainFilter.value == "Programmer") {
      final value = await APIService().fetchUserProgrammer();
      value.success!.forEach((element) {
        sales.add({"id": element.id, "name": element.name});
      });
    }
    if (mainFilter.value == "Multimedia") {
      final value = await APIService().fetchUserMultimedia();
      value.success!.forEach((element) {
        sales.add({"id": element.id, "name": element.name});
      });
    }
  }

  checkDataCount() async {
    filterLoading.value = true;
    if (mainFilter.value == "Sales Direct") {
      if (salesDirectType.value == "Visit") {
        final value = await APIService().fetchVisitReport(
          userId: salesId.value == 0 ? null : salesId.value,
        );
        filterLoading.value = false;
        filterCount.value = value.recordsFiltered!;
      }
      if (salesDirectType.value == "Calling") {
        final value = await APIService().fetchCallingReport(
          1,
          salesId.value == 0 ? null : salesId.value,
          null,
          null,
        );
        filterLoading.value = false;
        filterCount.value = value.recordsFiltered!;
      }
      if (salesDirectType.value == "Biaya - Biaya") {
        final value = await APIService().fetchFeeReport(
          1,
          salesId.value == 0 ? null : salesId.value,
          null,
          null,
        );
        filterLoading.value = false;
        filterCount.value = value.recordsFiltered!;
      }
    }
    if (mainFilter.value == "Sales Counter") {
      final value = await APIService().fetchSalesCounterReport(
        1,
        salesId.value == 0 ? null : salesId.value,
        null,
        null,
      );
      filterLoading.value = false;
      filterCount.value = value.recordsFiltered!;
    }
    if (mainFilter.value == "Programmer") {
      final value = await APIService().fetchProgrammerReport(
        1,
        salesId.value == 0 ? null : salesId.value,
        null,
        null,
      );
      filterLoading.value = false;
      filterCount.value = value.recordsFiltered!;
    }
    if (mainFilter.value == "Multimedia") {
      final value = await APIService().fetchMultimediaReport(
        1,
        salesId.value == 0 ? null : salesId.value,
        null,
        null,
      );
      filterLoading.value = false;
      filterCount.value = value.recordsFiltered!;
    }
  }

  void addFilter() async {
    report.close();
    isLoading.value = true;
    if (mainFilter.value == "Sales Direct") {
      if (salesDirectType.value == "Visit") {
        final value = await APIService().fetchVisitReport(
          userId: salesId.value == 0 ? null : salesId.value,
        );
        report.value = value;
        print(value.recordsTotal);
        isLoading.value = false;
      } else if (salesDirectType.value == "Calling") {
        APIService().fetchCallingReport(1, salesId.value == 0 ? null : salesId.value, null, null).then((value) {
          report.value = value;
          isLoading.value = false;
        });
      } else if (salesDirectType.value == "Biaya - Biaya") {
        APIService().fetchFeeReport(1, salesId.value == 0 ? null : salesId.value, null, null).then((value) {
          report.value = value;
          isLoading.value = false;
        });
      }
    } else if (mainFilter.value == "Sales Counter") {
      APIService().fetchSalesCounterReport(1, salesId.value == 0 ? null : salesId.value, null, null).then((value) {
        report.value = value;
        isLoading.value = false;
      });
    } else if (mainFilter.value == "Programmer") {
      APIService().fetchProgrammerReport(1, salesId.value == 0 ? null : salesId.value, null, null).then((value) {
        report.value = value;
        isLoading.value = false;
      });
    } else if (mainFilter.value == "Multimedia") {
      APIService().fetchMultimediaReport(1, salesId.value == 0 ? null : salesId.value, null, null).then((value) {
        report.value = value;
        isLoading.value = false;
      });
    }
  }

  clearFilter() {
    mainFilter.value = "Sales Direct";
    salesDirectType.value = "Visit";
    salesId.value = 0;
    salesName.value = "Semua Sales";
  }
}
