import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/user.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/users');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-Token': await AuthService.getToken()
      });
      final usersResp = usersResponseFromJson(resp.body);
      return usersResp.users;
    } catch (e) {
      return [];
    }
  }
}
