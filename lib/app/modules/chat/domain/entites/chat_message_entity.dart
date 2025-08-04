class ChatMessageEntity {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessageEntity({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });
}
