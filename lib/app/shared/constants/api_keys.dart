import 'package:my_chat_app/app/app_exports.dart';

class ApiKeys {
  static final String geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
}
