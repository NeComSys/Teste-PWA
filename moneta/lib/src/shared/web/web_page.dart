import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  var isWeb = kIsWeb;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            mediaSize.width > 450
                ? 'assets/images/background.jpg'
                : 'assets/images/background_mobile.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
            opacity: const AlwaysStoppedAnimation(.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: mediaSize.width,
      child: const Padding(
        // padding: EdgeInsets.symmetric(vertical: mediaSize.height / 3),
        padding: EdgeInsets.only(
          left: 25.0,
          top: 5.0,
          right: 25.0,
          bottom: 15.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bem vindo ao sistema de reembolso!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                fontFamily: 'Visby',
              ),
            ),
            Text.rich(
              softWrap: true,
              // textAlign: TextAlign.justify,
              TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                text:
                    'Para utilizar o sistema em seu dispositivo móvel, basta clicar no ícone ',
                children: [
                  WidgetSpan(
                    child: Image(
                      image: AssetImage("assets/icons/pwa.png"),
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: ' para efetuar a instalação do aplicativo.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
