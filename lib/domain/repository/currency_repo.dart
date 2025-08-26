import 'dart:developer';

import 'package:currency_rate_calculator/data/models/responce_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/config/env_config.dart';

class CurrencyRepository {
  final Dio _dio = Dio();
  final String baseUrl = EnvConfig.baseUrl;
  final String accessKey = EnvConfig.accessKey;

  Future<ResponseModel> convert({
    required String from,
    required String to,
    required double amount,
  }) async {
    try {
      log("work $baseUrl");
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'from': from,
          'to': to,
          'amount': amount,
          'access_key': accessKey,
        },
      );
      log("reesss$response");
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else {
        log("error $response");
        throw Exception('Failed with status ${response.statusCode}');
      }
    } catch (e) {
      log("error $e");
      throw Exception('Currency conversion failed: $e');
    }
  }
}
