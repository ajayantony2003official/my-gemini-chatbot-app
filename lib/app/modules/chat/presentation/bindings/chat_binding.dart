import 'package:get/get.dart';
import 'package:my_chat_app/app/modules/chat/chat_exports.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // API client
    Get.lazyPut<ApiClient>(() => ApiClient());

    // Remote data source
    Get.lazyPut<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(Get.find<ApiClient>()),
    );

    // Repository
    Get.lazyPut<ChatRepository>(
      () => ChatRepositoryImpl(Get.find<ChatRemoteDataSource>()),
    );

    // Use case
    Get.lazyPut<SendMessageUseCase>(
      () => SendMessageUseCase(Get.find<ChatRepository>()),
    );

    // Controller
    Get.lazyPut<ChatController>(
      () => ChatController(Get.find<SendMessageUseCase>()),
    );
  }
}
