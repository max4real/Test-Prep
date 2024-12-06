import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/_services/c_theme.dart';
import 'package:test_prep/modules/gateway/c_gateway_page.dart';

class GatewayPage extends StatelessWidget {
  const GatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GatewayController());
    ThemeController themeController = Get.find();
    return Scaffold(
      backgroundColor: themeController.onBackground,
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
                  color: themeController.background,
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
