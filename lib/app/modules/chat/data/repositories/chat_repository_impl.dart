import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource dataSource;
  ChatRepositoryImpl(this.dataSource);

  @override
  Future<ApiResponse<GeminiResponse>> sendMessage(String prompt) async {
    try {
      final response = await dataSource.sendMessage(prompt);
      if (response.isSuccess && response.data != null) {
        final model = response.data!;
        final GeminiResponse entity = GeminiResponse(text: model.text);
        return ApiResponse.success(entity);
      } else {
        return ApiResponse.error(response.error ?? 'Unknown error');
      }
    } catch (e) {
      return ApiResponse.error('Repository error: $e');
    }
  }
}
