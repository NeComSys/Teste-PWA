import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../models/auth_request_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Color myColor;
  late Size mediaSize;

  final credential = AuthRequestModel();
  late final AuthController controller;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FocusNode textFieldFocusNode;

  final _formKey = GlobalKey<FormState>();

  late bool isLoading;

  String version = 'Carregando...'; // Estado inicial enquanto carrega a versão
  String dateUpdated = '';

  @override
  void initState() {
    super.initState();
    fetchAppVersion(); // Ao iniciar a tela, carrega a versão do servidor
    controller = context.read<AuthController>();

    textFieldFocusNode = FocusNode();

    isLoading = false;

    controller.addListener(() {
      if (mounted) {
        if (controller.state == AuthState.error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.black,
                  size: 35,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Erro na autenticação. \nVerifique se os dados estão corretos!',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
          ));

          _formKey.currentState!.reset();
          // userNameController.clear();
          // passwordController.clear();
          textFieldFocusNode.requestFocus();

          // Validar o formulário após reset
          _formKey.currentState!.validate();
          isLoading = false;
          setState(() {});
        } else if (controller.state == AuthState.success) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (controller.state == AuthState.loading) {
          isLoading = true;
          setState(() {});
        } else if (controller.state == AuthState.warning) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 35,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    controller.exceptionMessage,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 244, 168, 54),
          ));

          isLoading = false;
          _formKey.currentState!.reset();
          // userNameController.clear();
          // passwordController.clear();
          textFieldFocusNode.requestFocus();

          // Validar o formulário após reset
          _formKey.currentState!.validate();
          setState(() {});
        }
      }
    });
  }

  Future<void> fetchAppVersion() async {
    try {
      final response = await http
          .get(Uri.parse('/version.json')); // Substitua pelo seu endpoint
      if (response.statusCode == 200) {
        final versionData = jsonDecode(response.body);
        setState(() {
          version = versionData['version'];
          dateUpdated = versionData['dateUpdated'];
        });
      } else {
        setState(() {
          version = 'Erro ao carregar a versão';
        });
      }
    } catch (error) {
      setState(() {
        version = 'Erro ao carregar a versão: $error';
      });
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool rememberUser = false;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    myColor = Colors.green;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color.fromARGB(255, 35, 138, 61),
                Color.fromARGB(255, 107, 141, 110),
                Color.fromARGB(255, 185, 212, 187),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 85),
              Image.asset(
                'assets/logos/Logo-Marko_FC.png',
                height: 85,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height - 210,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white, //.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 26, 75, 34).withOpacity(
                          0.5), // Define a cor e a opacidade da sombra
                      spreadRadius: 5, // Espalha a sombra
                      blurRadius: 7, // Aumenta a desfocagem da sombra
                      offset:
                          const Offset(0, 3), // Muda o deslocamento da sombra
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 0),
                      _buildForm(controller),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(controller) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.authPage_welcome,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            AppLocalizations.of(context)!.authPage_welcome_desc,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 45),
          _buildGreyText(AppLocalizations.of(context)!.authPage_text),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: userNameController,
            onChanged: credential.setUserName,
            validator: (value) => credential.userName.validate(),
            focusNode: textFieldFocusNode,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.authPage_userName,
              labelStyle: const TextStyle(fontSize: 13.0),
              prefixIcon: const Icon(Icons.account_circle_sharp),
            ),
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: passwordController,
            obscureText: isObscured,
            onChanged: credential.setPassword,
            validator: (value) => credential.password.validate(),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 15),
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context)!.authPage_password,
              labelStyle: const TextStyle(fontSize: 13.0),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon:
                    Icon(isObscured ? Icons.visibility_off : Icons.visibility),
              ),
            ),
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 30),
          _buildLoginButton(controller),
          const SizedBox(height: 10),
          Text(
            '${AppLocalizations.of(context)!.system_version} $version - $dateUpdated',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          // _buildLanguage(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _buildLoginButton(controller) {
    //final state = controller.state == AuthState.loading;
    return Container(
      alignment: Alignment.center,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            isLoading
                ? const Color.fromARGB(255, 151, 151, 151)
                : const Color.fromARGB(255, 35, 138, 61),
            isLoading
                ? const Color.fromARGB(255, 172, 172, 172)
                : const Color.fromARGB(255, 107, 141, 110),
            isLoading
                ? const Color.fromARGB(255, 192, 192, 192)
                : const Color.fromARGB(255, 185, 212, 187),
          ],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          fixedSize: const Size(250, 50),
          // elevation: 1.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: isLoading
            ? null
            : () {
                final validate = _formKey.currentState!.validate();
                if (validate == true) {
                  controller.loginAction(credential);
                }
                _formKey.currentState!.reset();
                // setState(() {});
              },
        child: Text(
          AppLocalizations.of(context)!.authPage_button_login,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
