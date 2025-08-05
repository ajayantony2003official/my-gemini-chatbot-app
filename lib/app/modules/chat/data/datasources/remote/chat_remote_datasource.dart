import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

abstract class ChatRemoteDataSource {
  Future<ApiResponse<GeminiResponseModel>> sendMessage(List<ChatMessageEntity> messages);
  Stream<String> streamMessage(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient apiClient;

  ChatRemoteDataSourceImpl(this.apiClient);
  @override
  Future<ApiResponse<GeminiResponseModel>> sendMessage(List<ChatMessageEntity> messages) async {
    final response = await apiClient.sendToGemini(messages);
    if (response.isSuccess && response.data != null) {
      try {
        final geminiResponse = GeminiResponseModel.fromJson(response.data);
        return ApiResponse.success(geminiResponse);
      } catch (e) {
        return ApiResponse.error("Failed to parse response: $e");
      }
    } else {
      return ApiResponse.error(response.error ?? "Unknown error");
    }
  }

  @override
  Stream<String> streamMessage(String message) {
    return apiClient.sendToGeminiStream(message);
  }
}
