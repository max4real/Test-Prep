import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/home/m/m_user_model.dart';
import 'package:test_prep/modules/shared/widgets/w_custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/constants/api_endpoint.dart';

class HomeController extends GetxController {
  List<UserModel> userList = [];
  bool xFetching = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    // dataController.saveState(isFirstTime: false);
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    String url = ApiEndPoint.usersURL;

    xFetching = true;
    update();
    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));
    final response = await client.get(url);
    xFetching = false;
    if (response.isOk) {
      List<UserModel> temp = [];
      Iterable iterable = response.body;
      for (var element in iterable) {
        UserModel rawData = UserModel.fromAPI(data: element);
        temp.add(rawData);
      }
      userList = temp;
    } else {
      showCustomDialog(
          message: "Something Went Wrong!", color: Colors.redAccent);
    }
    update();
  }

  Future<void> goToUrl(String url) async {
    final Uri uri = Uri.parse("https://$url");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
