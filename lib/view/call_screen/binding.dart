import 'package:get/get.dart';

import 'logic.dart';

class CallScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CallScreenLogic());
  }
}
