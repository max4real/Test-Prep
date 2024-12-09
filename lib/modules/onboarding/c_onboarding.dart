import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  final double dotSize = 10.0;
  
  void nextPage(int itemCount) {
    if (currentIndex.value < itemCount - 1) {
      currentIndex.value++;
      swipePage();
    }
  }

  void previousPage() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      swipePage();
    }
  }

  void movePage(int index) {
    currentIndex.value = index;
    swipePage();
  }

  void swipePage() {
    pageController.animateToPage(
      currentIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
