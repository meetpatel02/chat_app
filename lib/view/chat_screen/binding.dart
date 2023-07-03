import 'package:get/get.dart';

import 'logic.dart';

class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatScreenLogic());
  }
}
