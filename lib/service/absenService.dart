import 'dart:convert';

import 'package:absenku/model/AbsenModel.dart';
import 'package:absenku/service/api.dart';
import 'package:absenku/service/pref_handler.dart';
import 'package:absenku/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Absenservice {
  final dio = Dio();
  Future<absenModel> absenMasuk({
    required double lat,
    required double long,
    required String addres,
  }) async {
    String token = await PreferenceHandler.getToken();
    try {
      final res = await dio.post(
        "${UrlData.url}/api/absen/check-in",
        data: {
          "check_in_lat": lat,
          "check_in_lng": long,
          "check_in_address": addres,
          "status": "masuk",
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );

      return absenModel.fromJson(res.data, res.statusCode);
    } on DioException catch (e) {
      showToast(e.response!.data['message'], success: false);
      return absenModel.fromJson(e.response!.data, e.response!.statusCode);
    }
  }

  Future<absenModel> absenKeluar({
    required double lat,
    required double long,
    required String addres,
    required String latLong,
  }) async {
    String token = await PreferenceHandler.getToken();
    try {
      final res = await dio.post(
        "${UrlData.url}/api/absen/check-out",
        data: {
          "check_out_lat": lat,
          "check_out_lng": long,
          "check_out_location": latLong,
          "check_out_address": addres,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );

      return absenModel.fromJson(res.data, res.statusCode);
    } on DioException catch (e) {
      showToast(e.response!.data['message'], success: false);
      return absenModel.fromJson(e.response!.data, e.response!.statusCode);
    }
  }

  Future<absenModel> getHistoryHome() async {
    String token = await PreferenceHandler.getToken();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final dateNow = DateTime.now();
    final date7Back = DateTime.now().add(Duration(days: -7));
    try {
      final res = await dio.get(
        "${UrlData.url}/api/absen/history",
        queryParameters: {
          'start': dateFormat.format(date7Back),
          'end': dateFormat.format(dateNow),
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );

      return absenModel.fromListJson(res.data);
    } on DioException catch (e) {
      return absenModel.fromJson(e.response!.data, e.response!.statusCode);
    }
  }

  Future<absenModel> izin({
    required double lat,
    required double long,
    required String addres,
    required String aslasan,
  }) async {
    String token = await PreferenceHandler.getToken();
    try {
      final res = await dio.post(
        "${UrlData.url}/api/absen/check-in",
        data: {
          "check_in_lat": lat,
          "check_in_lng": long,
          "check_in_address": addres,
          "status": "izin",
          "alasan_izin": aslasan,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );
      return absenModel.fromJson(res.data, res.statusCode);
    } on DioException catch (e) {
      // print(e.message);
      // showToast(e.message.toString(), success: false);
      return absenModel.fromJson(e.response!.data, e.response!.statusCode);
    }
  }

  Future<absenModel> delete({required int idAbsen}) async {
    String token = await PreferenceHandler.getToken();
    showToast(idAbsen.toString(), success: false);
    try {
      final res = await dio.delete(
        "${UrlData.url}/api/absen/$idAbsen",
        options: Options(
          headers: {
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );
      print(res.data);
      return absenModel.fromJson(res.data, res.statusCode);
    } on DioException catch (e) {
      return absenModel.fromJson(e.response!.data, e.response!.statusCode);
    }
  }
}
