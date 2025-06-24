import 'package:flutter/material.dart';

import '../constents/text.dart';
import '../utils/responsive_helper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      padding: ResponsiveHelper.getHorizontalPadding(context).add(
        EdgeInsets.symmetric(vertical: isMobile ? 48 : 64),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Me',
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
          SizedBox(height: isMobile ? 24 : 32),
          if (isMobile)
            _buildMobileLayout(context)
          else
            _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              TextConstants.aboutUsImage,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildProfileInfo(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            TextConstants.aboutUsImage,
            width: isTablet ? 100 : 120,
            height: isTablet ? 100 : 120,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: isTablet ? 24 : 32),
        Expanded(
          child: _buildProfileInfo(context),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${TextConstants.profileName} T',
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
        SizedBox(height: isMobile ? 6 : 8),
        Text(
          'AI Integrated Cross-Platform Mobile App Developer',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 16,
              tablet: 17,
              desktop: 18,
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'With a passion for creating innovative mobile solutions, I specialize in cross-platform app development, ensuring seamless user experiences across various devices. My expertise spans from concept to deployment, delivering high-quality, efficient, and user-centric applications.',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            height: 1.6,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
