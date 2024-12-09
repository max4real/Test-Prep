import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/models/m_user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../_common/data/data_controller.dart';
import '../../_services/api_endpoint.dart';

class HomeController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<List<UserModel>> userList = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(true);

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

    xFetching.value = true;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));
    final response = await client.get(url);
    xFetching.value = false;
    if (response.isOk) {
      List<UserModel> temp = [];
      Iterable iterable = response.body;
      for (var element in iterable) {
        UserModel rawData = UserModel.fromAPI(data: element);
        temp.add(rawData);
      }
      userList.value = [...temp];
    } else {
      mySuccessDialog("Something Went Wrong!", false, Colors.redAccent);
    }
  }

  Future<void> goToUrl(String url) async {
    final Uri uri = Uri.parse("https://$url");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
