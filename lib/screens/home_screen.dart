import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constents/text.dart';
import '../controllers/home_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';
import '../widgets/hero_section.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/services_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/919656302654?text=Hello! I would like to connect with you.',
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch WhatsApp',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                TextConstants.profileName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildDrawerItem('About', () {
                Navigator.pop(context);
                controller.scrollToSection('about');
              }),
              _buildDrawerItem('Portfolio', () {
                Navigator.pop(context);
                controller.scrollToSection('portfolio');
              }),
              _buildDrawerItem('Services', () {
                Navigator.pop(context);
                controller.scrollToSection('services');
              }),
              _buildDrawerItem('Contact', () {
                Navigator.pop(context);
                controller.scrollToSection('contact');
              }),
            ],
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          controller.handleScroll(notification);
          return true;
        },
        child: Stack(
          children: [
            NestedScrollView(
              controller: controller.scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: SizedBox.shrink(),
                ),
              ],
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const HeroSection(),
                    AboutSection(key: controller.sectionKeys['about']),
                    PortfolioSection(key: controller.sectionKeys['portfolio']),
                    ServicesSection(key: controller.sectionKeys['services']),
                    ContactSection(key: controller.sectionKeys['contact']),
                    const Footer(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: controller.animationController,
                  curve: Curves.easeInOut,
                )),
                child: Material(
                  elevation: 2,
                  color: Colors.white,
                  child: FadeTransition(
                    opacity: controller.animationController,
                    child: Header(
                      onNavItemTap: controller.scrollToSection,
                      scaffoldKey: scaffoldKey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            onPressed: _launchWhatsApp,
            backgroundColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0,
            child: Lottie.asset(
              'assets/images/share.json',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String text, VoidCallback onTap) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
