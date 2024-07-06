import 'package:flutter/material.dart';
import 'package:moneta/src/shared/auth/ui/pages/auth_pages.dart';
import 'package:moneta/src/shared/home/ui/pages/home_page.dart';
import 'package:moneta/src/shared/splash/ui/pages/splash_page.dart';
import 'package:moneta/src/shared/web/web_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (_) => const SplashPage(),
    '/web_page': (_) => const WebPage(),
    '/auth': (_) => const AuthPage(),
    '/home': (_) => const HomePage(),
  };

  static String initial = '/';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //static List<NavigatorObserver> navigatorObservers = [MyNavigatorObserver()];
}
