import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../_services/api_endpoint.dart';
import '../../models/m_onbording_model.dart';

class DataController extends GetxController {
  ValueNotifier<List<OnbordingModel>> onbordingList = ValueNotifier([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> fetchOnboradingData() async {
    String url = ApiEndPoint.onbordingURL;

    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));
    final response = await client.get(url);

    if (response.isOk) {
      List<OnbordingModel> temp = [];
      Iterable iterable = response.body;
      for (var element in iterable) {
        OnbordingModel rawData = OnbordingModel.fromAPI(data: element);
        temp.add(rawData);
      }
      onbordingList.value = [...temp];
      print(onbordingList.value.length);
    } else {
      mySuccessDialog("Something Went Wrong!", false, Colors.redAccent);
    }
  }

  Future<bool> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? spFirstTime = prefs.getBool('spFirstTime');

    if (spFirstTime != null) {
      return spFirstTime;
    } else {
      return true;
    }
  }

  Future<void> saveState({required bool isFirstTime}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spFirstTime', isFirstTime);
  }
}

void mySuccessDialog(String message, bool type_, Color color) {
  Get.dialog(
    Dialog(
      backgroundColor: const Color(0XFF262D39),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: type_
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
