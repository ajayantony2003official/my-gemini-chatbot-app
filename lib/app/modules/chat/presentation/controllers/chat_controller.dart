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
          final responseText = result.data!.text.trim();

          // Add placeholder first
          final aiMessage = ChatMessageEntity(
            message: "",
            isUser: false,
            timestamp: DateTime.now(),
          );
          chatMessages.add(aiMessage);

          // Animate letter by letter
          for (int i = 0; i < responseText.length; i++) {
            await Future.delayed(const Duration(milliseconds: 15));
            aiMessage.message += responseText[i];
            chatMessages.refresh();
          }
        } else {
          Get.snackbar('Error', result.error ?? 'Unknown error');
        }
      } catch (e) {
        Get.snackbar('Exception', e.toString());
      }
    });
  }
}
