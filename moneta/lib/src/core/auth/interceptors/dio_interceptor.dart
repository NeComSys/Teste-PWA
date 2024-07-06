// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneta/src/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/auth/models/auth_response_model.dart';

class DioInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  late SharedPreferences _prefs;
  bool _isRefreshing = false;
  late BuildContext _context;

  DioInterceptor(this._dio, this._context);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final shared = await getShared();

    if (shared != null) {
      if (shared.jwToken != null && shared.jwToken!.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${shared.jwToken}';
      }
      if (kDebugMode) {
        // debugPrint(jsonEncode("Base Url: ${options.baseUrl}"));
        // debugPrint(jsonEncode("Endpoint: ${options.path}"));
        if (options.headers['Authorization'] != null) {
          // debugPrint(
          //     jsonEncode("Authorization: ${options.headers['Authorization']}"));
        }
        if (options.data != null) {
          // debugPrint("Payload: ${jsonEncode(options.data)}");
        }
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // debugPrint(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    if (response.statusCode == 401) {
      final data = response.data;
      if ((Utils.converterObjectKeyToLowerCase(data)['failed'] == true &&
          Utils.converterObjectKeyToLowerCase(data)['message'] ==
              'TOKEN_EXPIRED')) {
        if (!_isRefreshing) {
          _isRefreshing = true;
          await _refreshTokenAndRetry(response, handler);
          _isRefreshing = false;
        } else {
          handler.next(response);
          //_redirectToLogin(); // Redireciona para a tela de login
        }
      }
    } else {
      handler.next(response);
    }
  }

  void _redirectToLogin() {
    // Redireciona para a tela de login
    Navigator.pushNamedAndRemoveUntil(_context, '/auth', (route) => false);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final shared = await getShared();

    // Check if the user is unauthorized.
    // if (err.response?.statusCode == 401) {
    //   // Refresh the user's authentication token.
    //   try {
    //     await refreshToken(err.requestOptions);
    //   } on DioException catch (e) {
    //     handler.next(e);
    //   }
    //   // Retry the request.
    //   try {
    //     handler.resolve(await _retry(err.requestOptions, shared));
    //   } on DioException catch (e) {
    //     // If the request fails again, pass the error to the next interceptor in the chain.
    //     handler.next(e);
    //   }
    //   // Return to prevent the next interceptor in the chain from being executed.
    //   return;
    // }

    // Pass the error to the next interceptor in the chain.
    handler.next(err);
  }

  Future<AuthResponseModel?> getShared() async {
    final shared = await SharedPreferences.getInstance();
    if (shared.containsKey('AuthModel')) {
      return AuthResponseModel.fromMap(
          jsonDecode(shared.getString('AuthModel')!));
    }
    return null;
  }

  Future<void> _refreshTokenAndRetry(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      final novoToken = await getNewToken();
      _dio.options.headers['Authorization'] = 'Bearer $novoToken';

      final novaRequisicao = await _dio.request(response.requestOptions.path,
          options: Options(method: response.requestOptions.method));
      handler.resolve(novaRequisicao);
    } catch (e) {
      handler
          .reject(DioError(requestOptions: response.requestOptions, error: e));
    }
  }

  Future<Response> getNewToken() async {
    final shared = await SharedPreferences.getInstance();
    final refreshToken =
        AuthResponseModel.fromMap(jsonDecode(shared.getString('AuthModel')!))
            .refreshToken;

    final response = await _dio
        .post('/identity/refresh-token', data: {"refreshToken": refreshToken});

    await shared.clear();
    await shared.setString(
        'AuthModel', AuthResponseModel.fromMap(response.data).toJson());

    return response;
  }
}
