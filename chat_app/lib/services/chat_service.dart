import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late User targetUser;

  Future<List<Message>> getChat(String userID) async {
    final uri = Uri.parse('${Environment.apiUrl}/messages/$userID');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final messagesResponse = messagesResponseFromJson(resp.body);

    return messagesResponse.messages;
  }
}
