import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moneta/src/shared/auth/models/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interceptors/dio_interceptor.dart';

class ClientHttp {
  final dio = Dio();

  ClientHttp(BuildContext context) {
    BaseOptions options = BaseOptions(
        baseUrl: "url do site",
        validateStatus: (status) => true,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 3000), // 30 seconds
        receiveTimeout: const Duration(seconds: 3000), // 30 seconds
        contentType: 'application/json',
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods':
              'GET, POST, OPTIONS, PUT, PATCH, DELETE',
          'Access-Control-Allow-Headers':
              'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers',
          'Accept': '*/*'
        });
    dio.options = options;
    //_setupInterceptor(context);
  }

  void _setupInterceptor(BuildContext _context) {
    dio.interceptors.add(DioInterceptor(dio, _context));
    dio.interceptors.add(LogInterceptor(
      request: true,
      error: true,
      requestHeader: true,
      requestBody: true,
    ));
  }

  Future get(String url, dynamic params) async {
    final response = await dio.get(url, queryParameters: params);
    return response;
  }

  Future<Map<String, dynamic>> post(String url, {Map? data}) async {
    final response = await dio.post(url, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> put(String url, {Map? data}) async {
    final response = await dio.put(url, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> patch(String url, {data}) async {
    final response = await dio.patch(url, data: data);
    return response.data;
  }

  Future delete(String url) async {
    final response = await dio.delete(url);
    return response.data;
  }

  Future<AuthResponseModel?> getShared() async {
    final shared = await SharedPreferences.getInstance();
    if (shared.containsKey('AuthModel')) {
      return AuthResponseModel.fromMap(
          jsonDecode(shared.getString('AuthModel')!));
    }
    return null;
  }
}
