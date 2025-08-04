import 'package:http/http.dart' as http;
import 'package:my_chat_app/app/modules/chat/chat_exports.dart';
import 'package:my_chat_app/app/app_exports.dart';

class ApiClient {
  Future<ApiResponse> sendToGemini(String prompt) async {
    try {
      final String apiKey = GeminiConstants.apiKey;

      if (apiKey.isEmpty) {
        return ApiResponse.error('Missing API key');
      }

      final Uri uri = Uri.parse("${GeminiConstants.baseUrl}?key=$apiKey");
      final Map<String, dynamic> body = {
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      };

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return ApiResponse.success(decoded);
      } else {
        return ApiResponse.error(
          'API error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      return ApiResponse.error('Exception: $e');
    }
  }
}
