import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<ApiResponse<GeminiResponse>> call(String prompt) {
    return repository.sendMessage(prompt);
  }
}
