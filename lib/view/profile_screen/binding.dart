import 'package:get/get.dart';

import 'logic.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileScreenLogic());
  }
}
