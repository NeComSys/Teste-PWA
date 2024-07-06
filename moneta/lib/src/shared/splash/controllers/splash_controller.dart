import 'package:flutter/widgets.dart';
import 'package:moneta/src/shared/auth/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/models/auth_response_model.dart';

enum AuthState {
  logged,
  unLogged,
}

class SplashController extends ChangeNotifier {
  late AuthController authController;
  SplashController(this.authController);

  var state = AuthState.unLogged;

  Future<void> checkAuth() async {
    state = AuthState.unLogged;
    // await Future.delayed(const Duration(seconds: 2));
    final shared = await SharedPreferences.getInstance();
    // shared.clear();
    if (shared.containsKey('AuthModel')) {
      final authModel =
          AuthResponseModel.fromJson(shared.getString('AuthModel')!).toMap();
      if (authModel['id'] != null) {
        if (shared.getString('AuthModel') == null) {
          state = AuthState.unLogged;
          notifyListeners();
        } else {
          final actualDate = DateTime.now();
          final tokenExpiresOn = DateTime.parse(authModel['expiresOn']);

          if (actualDate.compareTo(tokenExpiresOn) != -1) {
            state = AuthState.unLogged;
            notifyListeners();
            shared.clear();
          } else {
            state = AuthState.logged;
            notifyListeners();
          }
        }
      } else {
        state = AuthState.unLogged;
        notifyListeners();
      }
    } else {
      state = AuthState.unLogged;
      notifyListeners();
    }
  }
}
