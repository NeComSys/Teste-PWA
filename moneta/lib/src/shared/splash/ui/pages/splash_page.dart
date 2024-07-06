// import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneta/src/shared/web/web_page.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import '../../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Size mediaSize;
  var isWeb = kIsWeb;
  late bool isRunningAsPwa;
  late SplashController controller;

  var modeDebug = true;

  @override
  void initState() {
    controller = Provider.of<SplashController>(context, listen: false);
    isRunningAsPwa =
        html.window.matchMedia('(display-mode: standalone)').matches;

    controller.addListener(handleStateChange);
    controller.checkAuth();

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(handleStateChange);
    super.dispose();
  }

  void handleStateChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // developer.log('Handling state change');
      if (mounted) {
        // developer.log('Mounted');
        //isRunningAsPwa = modeDebug;
        if (isRunningAsPwa) {
          // developer.log('isRunningAsPwa $isRunningAsPwa');
          // Se estiver rodando como PWA, direciona para a página de Login
          if (controller.state == AuthState.logged) {
            // developer.log('State ${controller.state}');
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (controller.state == AuthState.unLogged) {
            // developer.log('State ${controller.state}');
            Navigator.of(context).pushReplacementNamed('/auth');
          }
        } else {
          // developer.log('isRunningAsPwa $isRunningAsPwa');
          // developer.log('State ${controller.state}');
          // Se estiver rodando no navegador, direciona para a página de Bem Vindo
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => const WebPage()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLogo(),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image(
                image: const AssetImage("assets/logos/Logo-Marko_FC.png"),
                height: isWeb ? 160 : 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
