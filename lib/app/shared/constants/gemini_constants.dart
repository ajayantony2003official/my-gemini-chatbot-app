import 'package:my_chat_app/app/app_exports.dart';

class GeminiConstants {
  static final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  static const String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
}
