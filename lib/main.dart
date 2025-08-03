import 'package:my_chat_app/app/app_exports.dart';

void main() async {
  await dotenv.load(); // Load .env file before app starts
  runApp(const MyApp());
}
