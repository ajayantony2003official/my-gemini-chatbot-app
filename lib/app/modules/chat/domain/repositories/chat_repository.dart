import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

abstract class ChatRepository {
  Future<ApiResponse<GeminiResponse>> sendMessage(List<ChatMessageEntity> messages);
  Stream<String> streamMessage(String message);
}
