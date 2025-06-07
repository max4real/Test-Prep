import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/home/v/v_home.dart';
import 'package:test_prep/modules/onboarding/m/m_onbording_model.dart';
import 'package:test_prep/modules/onboarding/v/v_onboarding.dart';
import 'package:test_prep/modules/shared/services/sp_service.dart';
import 'package:test_prep/modules/shared/widgets/w_custom_dialog.dart';

import '../shared/constants/api_endpoint.dart';

class GatewayController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    bool sfState = await SpService.getState();
    await Future.delayed(const Duration(seconds: 1));
    if (sfState) {
      //go to onbording
      final list = await fetchOnboradingData();

      Get.offAll(() => OnboardingPage(onbordingList: list));
    } else {
      //go to home
      Get.offAll(() => const HomePage());
    }
  }

  Future<List<OnbordingModel>> fetchOnboradingData() async {
    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));

    final response = await client.get(ApiEndPoint.onbordingURL);

    List<OnbordingModel> list = [];
    if (response.isOk) {
      Iterable iterable = response.body;
      for (var element in iterable) {
        OnbordingModel rawData = OnbordingModel.fromAPI(data: element);
        list.add(rawData);
      }
    } else {
      showCustomDialog(
          message: "Something Went Wrong!", color: Colors.redAccent);
    }
    return list;
  }
}
