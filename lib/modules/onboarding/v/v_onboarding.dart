import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/onboarding/c/c_onboarding.dart';
import 'package:test_prep/modules/onboarding/m/m_onbording_model.dart';
import 'package:test_prep/modules/onboarding/w/w_custom_button.dart';
import 'package:test_prep/modules/onboarding/w/w_description.dart';
import 'package:test_prep/modules/onboarding/w/w_image.dart';
import 'package:test_prep/modules/onboarding/w/w_title.dart';
import 'package:test_prep/modules/shared/services/sp_service.dart';
import '../../home/v/v_home.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key, required this.onbordingList});
  final List<OnbordingModel> onbordingList;

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.updateCurrentIndex,
              itemCount: onbordingList.length,
              itemBuilder: (context, index) {
                final currentData = onbordingList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget(
                        imageKey: ValueKey(currentData.image),
                        image: currentData.image,
                      ),
                      const SizedBox(height: 30),
                      TitleWidget(
                        titleKey: ValueKey(currentData.title),
                        title: currentData.title,
                      ),
                      const SizedBox(height: 20),
                      DescriptionWidget(
                        descriptionKey: ValueKey(currentData.subtitle),
                        description: currentData.subtitle,
                      ),
                      const SizedBox(height: 30),
                      if (index == onbordingList.length - 1)
                        _buildGetStartedButton(),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildNavigationRow(),
          const SizedBox(height: 20),
          _buildPageIndicator(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return GestureDetector(
      onTap: () {
        SpService.saveState(isFirstTime: false);
        Get.offAll(() => const HomePage());
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFF2F7EF0),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
        child: const Text(
          "Get Started",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRow() {
    return Row(
      children: [
        Obx(
          () => CustomButton(
            onPressed: controller.previousPage,
            icon: Icons.arrow_back,
            offset: controller.currentIndex.value > 0
                ? Offset.zero
                : const Offset(-0.5, 0),
            opacity: controller.currentIndex.value > 0 ? 1.0 : 0.0,
          ),
        ),
        const Spacer(),
        Obx(
          () => CustomButton(
            onPressed: () => controller.nextPage(onbordingList.length),
            icon: Icons.arrow_forward,
            offset: controller.currentIndex.value != onbordingList.length - 1
                ? Offset.zero
                : const Offset(0.5, 0),
            opacity: controller.currentIndex.value != onbordingList.length - 1
                ? 1.0
                : 0.0,
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Obx(
      () => SizedBox(
        width: controller.dotSize * onbordingList.length * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onbordingList.length,
                (index) => GestureDetector(
                  onTap: () => controller.movePage(index),
                  child: Container(
                    width: controller.dotSize,
                    height: controller.dotSize,
                    margin: EdgeInsets.symmetric(horizontal: controller.dotSize / 2),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: controller.currentIndex.value *
                  controller.dotSize *
                  2,
              child: Container(
                width: controller.dotSize * 2,
                height: controller.dotSize,
                decoration: BoxDecoration(
                  color: const Color(0XFF2F7EF0),
                  borderRadius: BorderRadius.circular(controller.dotSize / 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
