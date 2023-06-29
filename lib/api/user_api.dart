import 'dart:convert';
import 'package:chat_app/Model/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DataController extends GetxController {
  User? user;
  var isDataLoading = false.obs;
  String url = 'https://dummyjson.com/users';
  getUserData() async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        user = User.fromJson(result);
      }
    } catch (e) {
      print('error');
    } finally {
      isDataLoading(false);
    }
  }
}
