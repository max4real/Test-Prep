import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_prep/modules/home/v/v_home.dart';

import 'package:test_prep/modules/onboarding/m/m_onbording_model.dart';
import 'package:test_prep/modules/onboarding/w/w_custom_button.dart';
import 'package:test_prep/modules/onboarding/w/w_description.dart';
import 'package:test_prep/modules/onboarding/w/w_image.dart';
import 'package:test_prep/modules/onboarding/w/w_title.dart';
import 'package:test_prep/modules/shared/services/shared_preferance_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.onBoardingList});
  final List<OnbordingModel> onBoardingList;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final double _dotSize = 10;
  void _movePage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.onBoardingList.length,
              itemBuilder: (context, index) {
                final currentData = widget.onBoardingList[index];
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
                      if (index == widget.onBoardingList.length - 1)
                        GestureDetector(
                          onTap: () {
                            // Handle "Get Started" action
                            SharedPreferanceService.saveState(
                                isFirstTime: false);
                            Get.offAll(() => const HomePage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0XFF2F7EF0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 100),
                            child: const Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              CustomButton(
                onPressed: () {
                  _movePage(_currentIndex - 1);
                },
                icon: Icons.arrow_back,
                offset: _currentIndex > 0 ? Offset.zero : const Offset(-0.5, 0),
                opacity: _currentIndex > 0 ? 1.0 : 0.0,
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  _movePage(_currentIndex + 1);
                },
                icon: Icons.arrow_forward,
                offset: _currentIndex != widget.onBoardingList.length - 1
                    ? Offset.zero
                    : const Offset(0.5, 0),
                opacity: _currentIndex != widget.onBoardingList.length - 1
                    ? 1.0
                    : 0.0,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: _dotSize * widget.onBoardingList.length * 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.onBoardingList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          _movePage(index);
                        },
                        child: Container(
                          width: _dotSize,
                          height: _dotSize,
                          margin:
                              EdgeInsets.symmetric(horizontal: _dotSize / 2),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: (_currentIndex * _dotSize * 2),
                  child: Container(
                    width: _dotSize * 2,
                    height: _dotSize,
                    decoration: BoxDecoration(
                      color: const Color(0XFF2F7EF0),
                      borderRadius: BorderRadius.circular(_dotSize / 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
