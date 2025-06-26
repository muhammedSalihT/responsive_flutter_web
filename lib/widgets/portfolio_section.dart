import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/responsive_helper.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  String? _hoveredIndex;
  int? _tappedIndex;

  final List<Map<String, dynamic>> _portfolioItems = const [
    {
      'title': 'Exam Winner Learing App',
      'description':
          '50K+ Downloads In Both Playstore And Appstore With Average Of 5⭐ Rating. The Ultimate Learning App Based On Kerala,India',
      'imagePath': 'assets/images/examwinner.webp',
      'color': Color(0xFFF1F8E9),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.winner.exam_winner&hl=en_IN',
      'app_url':
          'https://apps.apple.com/us/app/exam-winner-learning-app/id6471256966'
    },
    {
      'title': 'Souq Jumla/سوق الجملة',
      'description': 'A Multi Vendor Ecommerce App Based On Kuwait',
      'imagePath': 'assets/images/souq_user.webp',
      'color': Color(0xFFFFEBEE),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.souqjumla.souqjumla_user&hl=en_IN',
      'app_url': ''
    },
    {
      'title': 'MedVenture',
      'description': 'A Pharmacist Job Searching App.',
      'imagePath': 'assets/images/med.webp',
      'color': Color(0xFFFCE4EC),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.noviindus.medventure&hl=en_IN',
      'app_url':
          'https://apps.apple.com/us/app/medventure-dr-antos-academy/id6504522538'
    },
    {
      'title': 'HS Group/مجموعة هس',
      'description': 'An Ecommerce Admin App Based On Kuwait',
      'imagePath': 'assets/images/souq_admin.webp',
      'color': Color(0xFFE3F2FD),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.souqjumla.souq_jumla&hl=en_IN',
      'app_url': ''
    },
    {
      'title': 'Wonclick',
      'description':
          'A 10 Minutes Grocery Delivery App Located In Hydarabad,India',
      'imagePath': 'assets/images/wonclick.webp',
      'color': Color(0xFFFFF3E0),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.wonclick&hl=en_IN',
      'app_url': ''
    },
    {
      'title': 'Barakah Bazar',
      'description': 'A Ecommerce App For Fashion Products.',
      'imagePath': 'assets/images/barkha.webp',
      'color': Color(0xFFE8EAF6),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.barakahbazar.app&hl=en_IN',
      'app_url': ''
    },
    {
      'title': 'WONCLICK DELIVERY',
      'description': 'A Delivery Boy App.',
      'imagePath': 'assets/images/wonclick_delivery.webp',
      'color': Color(0xFFF3E5F5),
      'play_url':
          'https://play.google.com/store/apps/details?id=com.wonclick.delivery&hl=en_IN',
      'app_url': ''
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 64),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Portfolio',
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
        ),
        SizedBox(height: isMobile ? 24 : 32),
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: _portfolioItems.length,
          options: CarouselOptions(
            height: isMobile ? 300 : 350,
            enlargeCenterPage: true,
            viewportFraction: isMobile ? 0.75 : (isTablet ? 0.5 : 0.34),
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
            final item = _portfolioItems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildPortfolioItem(
                context,
                item['title'] as String,
                item['play_url'] as String,
                item['app_url'] as String,
                item['description'] as String,
                item['imagePath'] as String,
                item['color'] as Color,
                index == _currentIndex,
                index,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPortfolioItem(
      BuildContext context,
      String title,
      String playUrl,
      String appUrl,
      String description,
      String imagePath,
      Color bgColor,
      bool isCenter,
      [int? index]) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return GestureDetector(
      onTap: isMobile
          ? () {
              setState(() {
                _tappedIndex = _tappedIndex == index ? null : index;
              });
            }
          : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredIndex = title),
        onExit: (_) => setState(() => _hoveredIndex = null),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // transform: Matrix4.identity()..scale(0.9),
              child: Container(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 4 : 6),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 16,
                          tablet: 17,
                          desktop: 18,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isMobile ? 4 : 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 12,
                          tablet: 12,
                          desktop: 13,
                        ),
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isMobile && _tappedIndex == index)
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        final Uri uri = Uri.parse(appUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          'assets/images/apple-black-logo-svgrepo-com.svg',
                          width: 40,
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () async {
                        final Uri uri = Uri.parse(playUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          'assets/images/playstore-svgrepo-com.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!isMobile && _hoveredIndex == title)
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        final Uri uri = Uri.parse(
                          appUrl,
                        );
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      }, // TODO: Add App Store link
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          'assets/images/apple-black-logo-svgrepo-com.svg',
                          width: 40,
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () async {
                        final Uri uri = Uri.parse(
                          playUrl,
                        );
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      }, // TODO: Add Play Store link
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          'assets/images/playstore-svgrepo-com.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
