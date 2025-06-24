import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/responsive_helper.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _serviceItems = const [
    {
      'icon': Icons.devices,
      'title': 'Cross-Platform App Development',
      'description':
          'Building apps that work seamlessly on both iOS and Android.',
    },
    {
      'icon': Icons.design_services,
      'title': 'UI/UX Design',
      'description': 'Designing intuitive and engaging user interfaces.',
    },
    {
      'icon': Icons.code,
      'title': 'App Maintenance & Support',
      'description': 'Providing ongoing support and updates for your app.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 64, vertical: 10),
          child: Text(
            'Services',
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 24,
                tablet: 28,
                desktop: 32,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 24 : 32),
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: _serviceItems.length,
          options: CarouselOptions(
            height: isMobile ? 250 : 300,
            enlargeCenterPage: true,
            viewportFraction: isMobile ? 0.85 : (isTablet ? 0.6 : 0.34),
            autoPlay: true,
            enlargeFactor: .4,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final item = _serviceItems[index];
            return _buildServiceCard(
              context: context,
              icon: item['icon'] as IconData,
              title: item['title'] as String,
              description: item['description'] as String,
              isCenter: index == _currentIndex,
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required bool isCenter,
  }) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // transform: Matrix4.identity()..scale(isCenter ? 1.0 : 0.9),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : (isTablet ? 24 : 32)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: isMobile ? 40 : (isTablet ? 44 : 48),
              color: Colors.grey[800],
            ),
            SizedBox(height: isMobile ? 20 : 24),
            Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 18,
                  tablet: 19,
                  desktop: 20,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              description,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
