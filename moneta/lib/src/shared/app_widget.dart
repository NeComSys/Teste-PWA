import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneta/src/core/controllers/version_controller.dart';
import 'package:moneta/src/shared/routes.dart';
import 'package:moneta/src/shared/splash/controllers/splash_controller.dart';
import 'package:provider/provider.dart';

import '../core/auth/services/client_http.dart';
import 'auth/controllers/auth_controller.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: [
        Provider(create: (context) => ClientHttp(context)),
        ChangeNotifierProvider(
            create: (context) => AuthController(context.read())),
        ChangeNotifierProvider(
            create: (context) => SplashController(context.read())),
        ChangeNotifierProvider(
            create: (context) => VersionController()..loadVersion()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moneta',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.teal,
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('pt'),
        supportedLocales: const [
          Locale('en', 'EN'),
          Locale('pt', 'PT'),
          Locale('es', 'ES'),
        ],
        initialRoute: Routes.initial,
        routes: Routes.list,
        navigatorKey: Routes.navigatorKey,
        builder: (context, child) {
          return SafeArea(
            child: Scaffold(
              body: child,
            ),
          );
        },
      ),
    );
  }
}
