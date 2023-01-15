import 'dart:convert';
import 'package:extension_methods/core/utils/utils.dart';
import '../providers/opeanai/models/completions_data.dart';

class MessageSent implements Setable {
  final String id;
  final String text;
  final CompletionsData messageReceived;
  MessageSent({
    required this.id,
    required this.text,
    required this.messageReceived,
  });

  MessageSent copyWith({
    String? id,
    String? text,
    CompletionsData? messageReceived,
  }) {
    return MessageSent(
      id: id ?? this.id,
      text: text ?? this.text,
      messageReceived: messageReceived ?? this.messageReceived,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'messageReceived': messageReceived.toJson(),
    };
  }

  factory MessageSent.fromMap(Map<String, dynamic> map) {
    return MessageSent(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      messageReceived: CompletionsData.fromJson(map['messageReceived']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageSent.fromJson(String source) =>
      MessageSent.fromMap(json.decode(source));

  @override
  String toString() =>
      'MessageSent(id: $id, text: $text, messageReceived: $messageReceived)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageSent &&
        other.id == id &&
        other.text == text &&
        other.messageReceived == messageReceived;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ messageReceived.hashCode;

  @override
  int get key => hashCode;
}
