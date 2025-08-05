class ChatMessageEntity {
  String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessageEntity({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  Map<String, dynamic> toGeminiMap() {
    return {
      "role": isUser ? "user" : "model",
      "parts": [
        {"text": message}
      ],
    };
  }
}
