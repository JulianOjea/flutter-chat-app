import 'package:chat_app/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/widgets/blue_bttn.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels_.dart';
import 'package:chat_app/widgets/logo_.dart';

import 'package:chat_app/helpers/show_alert.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                      assetPath: 'assets/chat-logo.png', title: 'Talker'),
                  _Form(),
                  const Labels(
                    question: '¿No tienes cuenta?',
                    outlinedText: '¡Crea una ahora!',
                    route: 'signup',
                  ),
                  const Text('Términos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
        CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl),
        CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Password',
          textController: passCtrl,
          isPassword: true,
        ),
        BlueBttn(
          text: "Logueate",
          //Si se esta autenticando se manda a true y si no se manda el metodo
          //este cambio se hace mediante el provider
          onPressed: authService.authenticating
              ? () => {} //El botón no se está bloqueando
              : () async {
                  FocusScope.of(context).unfocus();
                  //con listen en false no redibuja el widget
                  final loginOK = await authService.login(
                      emailCtrl.text.trim(), passCtrl.text.trim());
                  if (loginOK) {
                    socketService.connect();
                    Navigator.pushReplacementNamed(context, 'users');
                  } else {
                    //show alert
                    showAlert(
                        context, 'Login incorrecto', 'Revise sus credenciales');
                  }
                },
        )
      ]),
    );
  }
}
