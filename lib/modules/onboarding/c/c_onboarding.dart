import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  final double dotSize = 10.0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void nextPage(int itemCount) {
    if (currentIndex.value < itemCount - 1) {
      updateCurrentIndex(currentIndex.value + 1);
    }
  }

  void previousPage() {
    if (currentIndex.value > 0) {
      updateCurrentIndex(currentIndex.value - 1);
    }
  }

  void movePage(int index) {
    updateCurrentIndex(index);
  }

  void updateCurrentIndex(int index) {
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
}
