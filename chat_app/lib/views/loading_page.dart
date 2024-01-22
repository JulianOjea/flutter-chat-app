import 'package:chat_app/views/login_page.dart';
import 'package:chat_app/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          return Center(
            child: Text('Espera...'),
          );
        },
        future: checkLoginState(context),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticate = await authService.isLoggedIn();
    if (context.mounted) {
      if (authenticate) {
        //TODO: Connect socket server
        //Navigator.pushReplacementNamed(context, 'users');
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const UsersPage(),
                transitionDuration: const Duration(milliseconds: 0)));
      } else {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const LoginPage(),
                transitionDuration: const Duration(milliseconds: 0)));
      }
    }
  }
}
