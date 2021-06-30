import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:report/Model/form-model.dart';
import 'package:report/Model/user-model.dart';

class APIService {
  // ignore: missing_return
  Future<UserModel> fetchUser() async {
    try {
      final loginResponse = await Dio().post('https://report.indofarm.id/api/login', data: {
        'username': 'adminyo',
        'password': 'adminangkasa123',
      });
      if (loginResponse.statusCode == 200) {
        final response = await Dio().get(
          'https://report.indofarm.id/api/user/list-user-direct',
          options: Options(headers: {'Authorization': 'Bearer ${loginResponse.data['auth_token']}'}),
        );
        print(response.data['data']);
        return userModelFromJson(jsonEncode(response.data));
      }
    } on DioError catch (e) {
      print(e.response.data);
    }
  }

  // ignore: missing_return
  Future<FormModel> fetchData(currentPage, salesId) async {
    try {
      final loginResponse = await Dio().post('https://report.indofarm.id/api/login', data: {
        'username': 'adminyo',
        'password': 'adminangkasa123',
      });
      if (loginResponse.statusCode == 200) {
        final response = await Dio().post(
            'https://report.indofarm.id/api/laporan/get-laporan-calling?page=$currentPage',
            options: Options(headers: {'Authorization': 'Bearer ${loginResponse.data['auth_token']}'}),
            data: {
              "filter_user_id": salesId,
            });
        print(response.data['data']);
        return formModelFromJson(jsonEncode(response.data));
      }
    } on DioError catch (e) {
      print(e.response.data);
    }
  }
}
