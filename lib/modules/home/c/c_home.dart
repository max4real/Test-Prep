import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/home/m/m_user_model.dart';
import 'package:test_prep/modules/shared/w/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/constants/api_endpoint.dart';

enum Status { a, b, c }

class HomeController extends GetxController {
  List<UserModel> userList = [];
  bool xFetching = true;

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  void initLoad() {
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
      userList = (response.body as Iterable)
          .map((e) => UserModel.fromAPI(data: e))
          .toList();
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
