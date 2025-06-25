import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../utils/responsive_helper.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      width: double.infinity,
      height: isMobile ? 300 : 400,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/200851311-35246972-5cd6-45d9-8bd1-6c2046d480e4.gif'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 16 : 24),
          SizedBox(
            width: isTablet ? 600 : (isMobile ? double.infinity : 800),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 20,
                  tablet: 40,
                  desktop: 48,
                ),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'WELCOME TO MY DEV. WORLD...',
                      speed: const Duration(milliseconds: 200),
                    ),
                    // FadeAnimatedText(
                    //   'Cross-Platform',
                    //   duration: const Duration(seconds: 2),
                    //   fadeOutBegin: 0.8,
                    //   fadeInEnd: 0.2,
                    // ),
                    // ScaleAnimatedText(
                    //   'Mobile Developer',
                    //   duration: const Duration(seconds: 2),
                    // ),
                  ],
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                ),
              ),
            ),
          ),
          // SizedBox(height: isMobile ? 16 : 24),
          // SizedBox(
          //   width: isTablet ? 500 : (isMobile ? double.infinity : 600),
          //   child: DefaultTextStyle(
          //     style: TextStyle(
          //       fontSize: ResponsiveHelper.getFontSize(
          //         context,
          //         mobile: 16,
          //         tablet: 18,
          //         desktop: 20,
          //       ),
          //       color: Colors.white.withOpacity(0.9),
          //       height: 1.5,
          //       shadows: [
          //         Shadow(
          //           color: Colors.black.withOpacity(0.3),
          //           offset: const Offset(1, 1),
          //           blurRadius: 2,
          //         ),
          //       ],
          //     ),
          //     child: AnimatedTextKit(
          //       animatedTexts: [
          //         TypewriterAnimatedText(
          //           'Crafting seamless mobile experiences across platforms',
          //           speed: const Duration(milliseconds: 100),
          //         ),
          //         TypewriterAnimatedText(
          //           'Building beautiful and responsive applications',
          //           speed: const Duration(milliseconds: 100),
          //         ),
          //         TypewriterAnimatedText(
          //           'Turning ideas into reality with Flutter',
          //           speed: const Duration(milliseconds: 100),
          //         ),
          //       ],
          //       repeatForever: true,
          //       pause: const Duration(seconds: 2),
          //     ),
          //   ),
          // ),
          // SizedBox(height: isMobile ? 24 : 32),
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Theme.of(context).colorScheme.primary,
          //     foregroundColor: Colors.white,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: isMobile ? 24 : 32,
          //       vertical: isMobile ? 12 : 16,
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: Text(
          //     'Explore Portfolio',
          //     style: TextStyle(
          //       fontSize: ResponsiveHelper.getFontSize(
          //         context,
          //         mobile: 14,
          //         tablet: 15,
          //         desktop: 16,
          //       ),
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
