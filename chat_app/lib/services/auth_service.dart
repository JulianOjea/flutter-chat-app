import 'dart:convert';
import 'package:chat_app/global/environment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/login_response.dart';

class AuthService with ChangeNotifier {
  User? user;
  //comprueba si se está autenticando y notifica a otro posible
  //widget de los cambios de este valor
  bool _isAuth = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticating => _isAuth;
  set authenticating(bool value) {
    _isAuth = value;

    notifyListeners(); //notifica a los que escuchan esta propiedad para que se actualicen
  }

  //Static token getters
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {'email': email, 'password': password};

    final url = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    authenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future signUp(String name, String email, String password) async {
    authenticating = true;
    final data = {'name': name, 'email': email, 'password': password};
    final url = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';

    final url = Uri.parse('${Environment.apiUrl}/login/renew');

    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      await _saveToken(loginResponse.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  //saving token
  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  //delete token from storage
  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
