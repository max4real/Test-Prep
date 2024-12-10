import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test_prep/modules/shared/constants/api_endpoint.dart';
import 'package:test_prep/modules/shared/constants/theme.dart';
import 'package:test_prep/modules/onboarding/m/m_onbording_model.dart';

import 'package:test_prep/modules/home/v/v_home.dart';
import 'package:test_prep/modules/onboarding/v/v_onboarding.dart';
import 'package:test_prep/modules/shared/w/custom_dialog.dart';

class GatewayPage extends StatefulWidget {
  const GatewayPage({super.key});

  @override
  State<GatewayPage> createState() => _GatewayPageState();
}

class _GatewayPageState extends State<GatewayPage> {
  @override
  void initState() {
    super.initState();
    initLoad();
  }

  Future<void> initLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool spFirstTime = prefs.getBool('spFirstTime') ?? true;

    await Future.delayed(const Duration(seconds: 1));
    if (spFirstTime) {
      //go to onbording
      final list = await fetchOnboradingData();
      Get.offAll(() => OnboardingPage(
            onBoardingList: list,
          ));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.primary,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/KanaOo Logo Header.png",
                width: 200,
              ),
            ),
          ),
          SizedBox(
            width: Get.width,
            height: 50,
            child: Center(
              child: Text(
                'Power by max4real',
                style: TextStyle(
                  color: ThemeController.background,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
