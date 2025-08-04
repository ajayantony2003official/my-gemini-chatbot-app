import 'package:my_chat_app/app/app_exports.dart';
import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

class ChatController extends BaseController {
  final SendMessageUseCase sendMessageUseCase;

  ChatController(this.sendMessageUseCase);

  final RxList<ChatMessageEntity> chatMessages = <ChatMessageEntity>[].obs;

  Future<void> sendMessage(String prompt) async {
    await runWithLoading(() async {
      // Add user's message to chat
      chatMessages.add(
        ChatMessageEntity(
          message: prompt,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );

      try {
        final result = await sendMessageUseCase(prompt);
        if (result.isSuccess) {
          // Add AI response to chat
          chatMessages.add(
            ChatMessageEntity(
              message: result.data!.text,
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        } else {
          Get.snackbar('Error', result.error ?? 'Unknown error');
        }
      } catch (e) {
        Get.snackbar('Exception', e.toString());
      }
    });
  }
}
