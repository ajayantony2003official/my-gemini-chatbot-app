import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<ApiResponse<GeminiResponse>> call(List<ChatMessageEntity> messages) {
    return repository.sendMessage(messages);
  }

  Stream<String> callStream(String prompt) {
    return repository.streamMessage(prompt);
  }
}
