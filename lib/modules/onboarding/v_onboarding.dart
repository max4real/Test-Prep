import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/_common/data/data_controller.dart';
import 'package:test_prep/modules/onboarding/w_custom_button.dart';
import 'package:test_prep/modules/onboarding/w_description.dart';
import 'package:test_prep/modules/onboarding/w_image.dart';
import 'package:test_prep/modules/onboarding/w_title.dart';

import '../home/v_home.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  DataController dataController = Get.find();
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final double _dotSize = 10;

  void _nextPage() {
    setState(() {
      if (_currentIndex != dataController.onbordingList.value.length - 1) {
        _currentIndex++;
        _swipePage();
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _swipePage();
      }
    });
  }

  void _movePage(int index) {
    setState(() {
      _currentIndex = index;
      _swipePage();
    });
  }

  void _swipePage() {
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
              itemCount: dataController.onbordingList.value.length,
              itemBuilder: (context, index) {
                final currentData = dataController.onbordingList.value[index];
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
                      if (index ==
                          dataController.onbordingList.value.length - 1)
                        GestureDetector(
                          onTap: () {
                            // Handle "Get Started" action
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 18),
          //   child: SizedBox(
          //     width: Get.width,
          //     height: 500,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         ImageWidget(
          //           imageKey: ValueKey(currentData.image),
          //           image: currentData.image,
          //         ),
          //         const SizedBox(height: 30),
          //         TitleWidget(
          //           titleKey: ValueKey(currentData.title),
          //           title: currentData.title,
          //         ),
          //         const SizedBox(height: 20),
          //         DescriptionWidget(
          //           descriptionKey: ValueKey(currentData.subtitle),
          //           description: currentData.subtitle,
          //         ),
          //         const SizedBox(height: 30),
          //         if (_currentIndex ==
          //             dataController.onbordingList.value.length - 1)
          //           GestureDetector(
          //             onTap: () {},
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: const Color(0XFF2F7EF0),
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               padding: const EdgeInsets.symmetric(
          //                   vertical: 8, horizontal: 100),
          //               child: const Text(
          //                 "Get Started",
          //                 style: TextStyle(
          //                   fontSize: 14,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
          // const Spacer(),
          Row(
            children: [
              CustomButton(
                onPressed: () {
                  _previousPage();
                },
                icon: Icons.arrow_back,
                offset: _currentIndex > 0 ? Offset.zero : const Offset(-0.5, 0),
                opacity: _currentIndex > 0 ? 1.0 : 0.0,
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  _nextPage();
                },
                icon: Icons.arrow_forward,
                offset: _currentIndex !=
                        dataController.onbordingList.value.length - 1
                    ? Offset.zero
                    : const Offset(0.5, 0),
                opacity: _currentIndex !=
                        dataController.onbordingList.value.length - 1
                    ? 1.0
                    : 0.0,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: _dotSize * dataController.onbordingList.value.length * 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    dataController.onbordingList.value.length,
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
