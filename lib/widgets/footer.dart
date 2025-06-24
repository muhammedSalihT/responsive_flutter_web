import 'package:flutter/material.dart';

import '../utils/responsive_helper.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: Colors.grey[900],
      child: Center(
        child: Text(
          '© ${DateTime.now().year} Salih. All rights reserved.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 12,
              tablet: 13,
              desktop: 14,
            ),
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildQuickLinks(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuickLinks(context),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Wrap(
      spacing: isMobile ? 16 : 24,
      runSpacing: 8,
      children: [
        _buildLink(context, 'About'),
        _buildLink(context, 'Portfolio'),
        _buildLink(context, 'Services'),
        _buildLink(context, 'Contact'),
      ],
    );
  }

  Widget _buildLink(BuildContext context, String text) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(
            context,
            mobile: 13,
            tablet: 14,
            desktop: 15,
          ),
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
