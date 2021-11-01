import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/Model/login-detail-model.dart';
import 'package:report/Model/sales-direct-detail-model.dart';
import 'package:report/Model/user-model.dart';

const baseUrl = 'https://report.indofarm.id/api';
const timeOut = 1000 * 10;

class APIService {
  final box = GetStorage();

  static var options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: timeOut,
    receiveTimeout: timeOut,
    sendTimeout: timeOut,
  );

  Dio dio = Dio(options);

  Future<LoginDetail> fetchUserDetail() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${box.read('token')}';
      final response = await dio.get('$baseUrl/detail');
      return loginDetailFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<UserModel> fetchSalesUserDirect() async {
    try {
      final response = await dio.get('$baseUrl/user/list-user-direct');
      return userModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await dio.post('$baseUrl/login', data: {
        'username': username,
        'password': password,
      });
      await box.write('token', response.data['auth_token']);
      return response.data;
    } on HttpException catch (e) {
      throw e.message;
    } on SocketException {
      throw SocketException('No internet connection');
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<void> logout() async {
    try {
      await Dio().post('$baseUrl/logout');
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<UserModel> fetchUserCounter() async {
    try {
      final response = await dio.get('$baseUrl/user/list-user-counter');
      return userModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<UserModel> fetchUserProgrammer() async {
    try {
      final response = await dio.get('$baseUrl/user/list-user-programmer');
      return userModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<UserModel> fetchUserMultimedia() async {
    try {
      final response = await dio.get('$baseUrl/user/list-user-multimedia');
      return userModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<FormModel> fetchVisitReport({int? page, int? userId, DateTime? fromDate, DateTime? toDate}) async {
    try {
      final response = await dio.post('$baseUrl/laporan/get-laporan-visit?page=${page == null ? null : page}', data: {
        "filter_user_id": userId == null ? null : userId,
        "filter_date_start": fromDate == null ? null : fromDate.toString(),
        "filter_date_end": toDate == null ? null : toDate.toString(),
      });
      print(response.data);
      return formModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<FormModel> fetchCallingReport(currentPage, userId, fromDate, toDate) async {
    try {
      final response = await dio.post('$baseUrl/laporan/get-laporan-calling?page=$currentPage', data: {
        "filter_user_id": userId,
        "filter_date_start": fromDate == null ? null : fromDate.toString(),
        "filter_date_end": toDate == null ? null : toDate.toString(),
      });
      return formModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<FormModel> fetchFeeReport(currentPage, userId, fromDate, toDate) async {
    try {
      final url = '$baseUrl/laporan/get-laporan-biaya?page=$currentPage';
      final response = await dio.post(url, data: {
        "filter_user_id": userId,
        "filter_date_start": fromDate == null ? null : fromDate.toString(),
        "filter_date_end": toDate == null ? null : toDate.toString(),
      });
      return formModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<FormModel> fetchSalesCounterReport(currentPage, userId, fromDate, toDate) async {
    try {
      final url = '$baseUrl/laporan/get-laporan-counter';
      final response = await dio.post('$url?page=$currentPage', data: {
        "filter_user_id": userId,
        "filter_date_start": fromDate == null ? null : fromDate.toString(),
        "filter_date_end": toDate == null ? null : toDate.toString(),
      });
      return formModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<FormModel> fetchProgrammerReport(currentPage, userId, fromDate, toDate) async {
    try {
      final url = '$baseUrl/laporan/get-laporan-programmer';
      final response = await dio.post('$url?page=$currentPage', data: {
        "filter_user_id": userId,
        "filter_date_start": fromDate == null ? null : fromDate.toString(),
        "filter_date_end": toDate == null ? null : toDate.toString(),
      });
      return formModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<FormModel> fetchMultimediaReport(currentPage, userId, fromDate, toDate) async {
    try {
      final url = '$baseUrl/laporan/get-laporan-multimedia';
      final response = await dio.post('$url?page=$currentPage', data: {
        "filter_user_id": userId,
        "filter_date_start": fromDate == null ? null : fromDate.toString(),
        "filter_date_end": toDate == null ? null : toDate.toString(),
      });
      return formModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future<SalesDirectDetailModel> fetchSalesDirectReportDetail(id) async {
    try {
      final url = '$baseUrl/laporan/detail-laporan/$id';
      final response = await dio.get(url);
      return salesDirectDetailModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }
}
