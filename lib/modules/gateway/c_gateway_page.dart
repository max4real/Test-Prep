import 'package:get/get.dart';
import 'package:test_prep/modules/home/v_home.dart';
import 'package:test_prep/modules/onboarding/v_onboarding.dart';

import '../../_common/data/data_controller.dart';

class GatewayController extends GetxController {
  DataController dataController = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    bool sfState = await dataController.getState();
    await Future.delayed(const Duration(seconds: 1));
    if (sfState == true) {
      //go to onbording
      await dataController.fetchOnboradingData();
      await Future.delayed(const Duration(seconds: 1));

      Get.offAll(() => OnboardingPage());
    } else {
      //go to home
      Get.offAll(() => const HomePage());
    }
  }
}
