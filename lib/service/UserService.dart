import 'dart:convert';

import 'package:absenku/model/AuthModel.dart';
import 'package:absenku/model/ProfileModel.dart';
import 'package:absenku/service/api.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:absenku/utils/toast.dart';
import 'package:dio/dio.dart';

class UserService {
  final dio = Dio();
  Future<bool> login({required String email, required String password}) async {
    try {
      final res = await dio.post(
        "${UrlData.url}/api/login",
        data: {"email": email, "password": password},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      final AuthModel response = AuthModel.fromJson(res.data);

      if (res.statusCode == 200) {
        PreferenceHandler.saveToken(response.data!.token.toString());

        return true;
      } else {
        showToast(res.statusMessage.toString(), success: false);
        return false;
      }
    } catch (e) {
      showToast(e.toString(), success: false);
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String nama,
  }) async {
    try {
      final res = await dio.post(
        "${UrlData.url}/api/register",
        options: Options(headers: {'Accept': 'application/json'}),
        data: {"name": nama, "email": email, "password": password},
      );
      final AuthModel response = AuthModel.fromJson(res.data);
      if (res.statusCode == 200) {
        PreferenceHandler.saveToken(response.data!.token.toString());
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  //
  Future<ProfileModel> getProfile() async {
    String token = await PreferenceHandler.getToken();
    try {
      final res = await dio.get(
        "${UrlData.url}/api/profile",
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return ProfileModel.fromJson(res.data);
    } on DioException catch (e) {
      showToast(e.response!.data['message'], success: false);
      return ProfileModel.fromJson({});
    }
  }

  Future<ProfileModel> updateProfile({
    required String email,
    required String nama,
  }) async {
    String token = await PreferenceHandler.getToken();
    try {
      final res = await dio.put(
        "${UrlData.url}/api/profile",
        data: {"name": nama, "email": email},
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return ProfileModel.fromJson(res.data);
    } on DioException catch (e) {
      showToast(e.response!.data['message'], success: false);
      return ProfileModel.fromJson({});
    }
  }
}
