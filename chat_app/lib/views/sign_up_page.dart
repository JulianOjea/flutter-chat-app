import 'package:chat_app/widgets/blue_bttn.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels_.dart';
import 'package:chat_app/widgets/logo_.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                    assetPath: 'assets/chat-logo.png',
                    title: 'Sign Up',
                  ),
                  _Form(),
                  const Labels(
                    question: '¿Ya tienes una cuenta?',
                    outlinedText: '¡Logueate!',
                    route: 'login',
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
        CustomInput(
            icon: Icons.person,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl),
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
            onPressed: () {
              print("Do something");
            })
      ]),
    );
  }
}
