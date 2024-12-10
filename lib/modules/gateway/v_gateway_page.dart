import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/shared/constants/c_theme.dart';
import 'package:test_prep/modules/gateway/c_gateway_page.dart';

class GatewayPage extends StatefulWidget {
  const GatewayPage({super.key});

  @override
  State<GatewayPage> createState() => _GatewayPageState();
}

class _GatewayPageState extends State<GatewayPage> {
  @override
  void initState() {
    Get.put(GatewayController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.onBackground,
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
