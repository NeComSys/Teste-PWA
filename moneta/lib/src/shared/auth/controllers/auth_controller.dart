import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moneta/src/core/utils/utils.dart';
import 'package:moneta/src/shared/auth/models/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/auth/constants/rest_constants.dart';
import '../../../core/auth/services/client_http.dart';
import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';

enum AuthState { idle, success, error, loading, sectionExpirade, warning }

class AuthController extends ChangeNotifier {
  final ClientHttp clientHttp;
  // var authRequest = AuthRequestModel();

  var state = AuthState.idle;

  String _exceptionMessage = '';
  String get exceptionMessage => _exceptionMessage;

  AuthController(this.clientHttp);

  final String urlToken =
      '/${RestConstants.portalEndpointUrl}/pt-BR/${RestConstants.authEndpoints.authUrl}/${RestConstants.authEndpoints.tokenUrl}';

  final String urlRefreshToken =
      '/${RestConstants.portalEndpointUrl}/pt-BR/${RestConstants.authEndpoints.authUrl}/${RestConstants.authEndpoints.tokenRefreshUrl}';

  Future<void> loginAction(AuthRequestModel credential) async {
    state = AuthState.loading;
    notifyListeners();

    try {
      final response = await clientHttp.post(urlToken, data: {
        'userName': credential.userName.value,
        'password': credential.password.value,
        'authType': 0
      });

      // await Future.delayed(const Duration(seconds: 5));

      if (Utils.converterObjectKeyToLowerCase(response)['failed']) {
        setSharedPreferences(
            Utils.converterObjectKeyToLowerCase(response)['data']);
        state = AuthState.warning;
        _exceptionMessage =
            Utils.converterObjectKeyToLowerCase(response)['message'];
      } else {
        // setSharedPreferences(
        //     Utils.converterObjectKeyToLowerCase(response)['data']);
        // simular erro
        state = AuthState.error; //state = AuthState.success;
      }

      notifyListeners();
    } on DioException catch (e) {
      print(e);
      state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> refreshToken() async {
    try {
      final shared = await SharedPreferences.getInstance();
      final refreshToken =
          AuthResponseModel.fromMap(jsonDecode(shared.getString('AuthModel')!))
              .refreshToken;

      final response = await clientHttp
          .post(urlRefreshToken, data: {"refreshToken": refreshToken});

      if (Utils.converterObjectKeyToLowerCase(response)['statusCode'] != 401) {
        setSharedPreferences(
            Utils.converterObjectKeyToLowerCase(response)['data']);
        state = AuthState.success;
      } else if (Utils.converterObjectKeyToLowerCase(response)['statusCode'] ==
          401) {
        state = AuthState.sectionExpirade;
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e);
      state = AuthState.error;
      notifyListeners();
    }
  }

  static Future<String?> getTokenExpired() async {
    final preferences = await SharedPreferences.getInstance();
    final token =
        AuthResponseModel.fromJson(preferences.getString('AuthModel')!).toMap();

    return token['expiresOn'];
  }

  static Future<void> setSharedPreferences(object) async {
    final _pref = await SharedPreferences.getInstance();

    String normalizedSource =
        base64Url.normalize(object['jwToken'].split(".")[1]);
    var user = json.decode(utf8.decode(base64Url.decode(normalizedSource)));

    await _pref.setString(
        'UserModel', UserResponseModel.fromMap(user).toJson());
    await _pref.setString(
        'AuthModel', AuthResponseModel.fromMap(object).toJson());
  }
}
