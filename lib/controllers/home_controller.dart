import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  Timer? scrollTimer;
  final RxBool isScrolling = false.obs;
  final RxBool isHorizontalScrolling = false.obs;
  final ScrollController scrollController = ScrollController();

  final Map<String, GlobalKey> sectionKeys = {
    'about': GlobalKey(),
    'portfolio': GlobalKey(),
    'services': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController.forward(); // Show header initially
  }

  @override
  void onClose() {
    animationController.dispose();
    scrollTimer?.cancel();
    scrollController.dispose();
    super.onClose();
  }

  void handleScroll(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.horizontal) {
      return;
    }
    if (notification is ScrollUpdateNotification) {
      // Hide header when scrolling starts
      if (!isScrolling.value) {
        isScrolling.value = true;
        animationController.reverse();
      }
      scrollTimer?.cancel();
    }

    // Show header when scrolling ends
    if (notification is ScrollEndNotification) {
      scrollTimer?.cancel();
      scrollTimer = Timer(const Duration(milliseconds: 200), () {
        isScrolling.value = false;
        animationController.forward();
      });
    }
  }

  void scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
