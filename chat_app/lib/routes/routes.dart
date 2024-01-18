import 'package:flutter/material.dart';

import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/loading_page.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:chat_app/views/sign_up_page.dart';
import 'package:chat_app/views/users_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => UsersPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => const LoginPage(),
  'signup': (_) => SignUpPage(),
  'loading': (_) => LoadingPage(),
};
