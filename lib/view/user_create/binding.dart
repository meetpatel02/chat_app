import 'package:get/get.dart';

import 'logic.dart';

class UserCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserCreateLogic());
  }
}
