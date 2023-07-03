import 'package:get/get.dart';

import 'logic.dart';

class PhoneLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneLoginLogic());
  }
}
