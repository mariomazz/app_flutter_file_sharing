import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../common/message_sent.dart';
import '../../constants.dart';
import '../../services/aescbc/aes_cbc.dart';
import 'models/completions_data.dart';

class OpenAiServiceProvider with ChangeNotifier {
  final String apiKey;
  final List<MessageSent> _messagesSent = [];
  List<MessageSent> get messagesSent => _messagesSent;
  OpenAiServiceProvider({
    required this.apiKey,
  });

  Future<CompletionsData> _sendMessage(String message) async {
    final AESAlgorithm service = AESAlgorithm();
    final decriptString =
        service.decrypt(apiKey, "PElfRNKvGnzfnMLm", "PElfRNKvGnzfnMLm");
    final response = await Dio().post(
      "${openAIAPIURL}completions",
      data: jsonEncode({
        "model": "text-davinci-003",
        "prompt": message,
        "max_tokens": 4000,
        "temperature": 0
      }),
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $decriptString",
      }),
    );

    if (!(((response.statusCode ?? 0) >= 200) &&
        ((response.statusCode ?? 0) <= 299))) {
      throw Exception("Error , Response => StatusCode error");
    }

    return CompletionsData.fromJson(response.data);
  }

  Future<void> sendMessageAndSave(String message) async {
    if (message.isEmpty) {
      return;
    }
    final data = await _sendMessage(message);
    _messagesSent.add(MessageSent(
      id: const Uuid().v1(),
      text: message,
      messageReceived: data,
    ));
    notifyListeners();
  }
}
