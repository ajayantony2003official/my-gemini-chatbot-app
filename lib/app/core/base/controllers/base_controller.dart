import 'package:my_chat_app/app/app_exports.dart';

class BaseController extends GetxController {
  final RxBool isLoading = false.obs;

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;

  Future<void> runWithLoading(Future<void> Function() task) async {
    try {
      showLoading();
      await task();
    } finally {
      hideLoading();
    }
  }
}
