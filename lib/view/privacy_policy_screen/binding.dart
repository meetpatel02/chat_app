import 'package:get/get.dart';

import 'logic.dart';

class PrivacyPolicyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyScreenLogic());
  }
}
