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

  Stream<String> sendToGeminiStream(String prompt) async* {
    final String apiKey = GeminiConstants.apiKey;

    if (apiKey.isEmpty) {
      yield 'Missing API key';
      return;
    }

    final Uri uri = Uri.parse("${GeminiConstants.baseUrl}?key=$apiKey");

    final Map<String, dynamic> body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt},
          ],
        },
      ],
      "stream": true, // 🔥 Enable streaming
    };

    final request = http.Request("POST", uri);
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(body);

    final response = await request.send();

    if (response.statusCode != 200) {
      yield 'API error: ${response.statusCode} - ${response.reasonPhrase}';
      return;
    }

    // Decode and yield text chunks
    await for (var chunk in response.stream.transform(utf8.decoder)) {
      // Google returns each streamed JSON block separately
      try {
        final jsonChunk = jsonDecode(chunk);

        final candidates = jsonChunk["candidates"] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final parts = candidates.first["content"]["parts"] as List?;
          if (parts != null && parts.isNotEmpty) {
            final text = parts.first["text"];
            if (text != null) {
              yield text;
            }
          }
        }
      } catch (e) {
        // It's normal to get partial chunks, so we skip invalid ones
      }
    }
  }
}
