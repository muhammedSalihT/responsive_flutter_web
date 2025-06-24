import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/constents/text.dart';
import 'package:portfolio/screens/resume_pdf_screen.dart';

import '../utils/responsive_helper.dart';

class Header extends StatelessWidget {
  final Function(String) onNavItemTap;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Header({
    super.key,
    required this.onNavItemTap,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: ResponsiveHelper.getHorizontalPadding(context).add(
        EdgeInsets.symmetric(vertical: isMobile ? 12 : 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Text(
            TextConstants.profileName,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 20,
                tablet: 22,
                desktop: 24,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                )
              else
                Row(
                  children: [
                    _buildNavItem('About', onTap: () => onNavItemTap('about')),
                    _buildNavItem('Portfolio',
                        onTap: () => onNavItemTap('portfolio')),
                    _buildNavItem('Services',
                        onTap: () => onNavItemTap('services')),
                    _buildNavItem('Contact',
                        onTap: () => onNavItemTap('contact')),
                  ],
                ),
              InkWell(
                onTap: () {
                  _showResumePDF(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/curriculum-resume-svgrepo-com.svg',
                      height: 40,
                      width: 40,
                    ),
                    const Text(
                      'My CV',
                      style: TextStyle(
                          color: Color(0xff194F82),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, {required VoidCallback onTap}) {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.isTablet(context) ? 12 : 16,
        ),
        child: InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 14,
                tablet: 15,
                desktop: 16,
              ),
              fontWeight: FontWeight.w500,
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

  void _showResumePDF(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResumePDFScreen(),
      ),
    );
  }
}
