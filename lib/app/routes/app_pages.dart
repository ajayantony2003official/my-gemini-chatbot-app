import 'package:my_chat_app/app/app_exports.dart';
import 'package:my_chat_app/app/routes/route_exports.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.chat, page: () => const ChatView()),
  ];
}
