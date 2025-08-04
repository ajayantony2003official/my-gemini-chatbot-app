import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

class GeminiResponseModel extends GeminiResponse {
  GeminiResponseModel({required super.text});

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      final String message =
          json['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
      return GeminiResponseModel(text: message);
    } catch (e) {
      return GeminiResponseModel(text: 'Error parsing response');
    }
  }
}
