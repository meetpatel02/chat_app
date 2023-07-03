import 'package:get/get.dart';

import '../../api/user_api.dart';
import 'state.dart';

class HomeScreenLogic extends GetxController {
  final HomeScreenState state = HomeScreenState();
  bool isMe = true;
  List user = ['Meet', 'Kush', 'jimiljathu', 'vraj', 'darshc'];
  DataController dataController = Get.put(DataController());
}
