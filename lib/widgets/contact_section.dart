import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/mailer_services.dart';
import '../utils/responsive_helper.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  final _mailerService = MailerServices();

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _mailerService.sendMail(recipient: _emailController.text);

      // Clear form after successful send
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      padding: ResponsiveHelper.getHorizontalPadding(context).add(
        EdgeInsets.symmetric(vertical: isMobile ? 48 : 64),
      ),
      child:
          isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactInfo(context),
        const SizedBox(height: 32),
        _buildFollowMeSection(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final bool isTablet = ResponsiveHelper.isTablet(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildContactInfo(context)),
        SizedBox(width: isTablet ? 32 : 48),
        Expanded(flex: 2, child: _buildFollowMeSection(context)),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
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
          SizedBox(height: isMobile ? 20 : 24),
          _buildTextField(
            context: context,
            label: 'Name',
            hint: 'Enter your name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context: context,
            label: 'Email',
            hint: 'Enter your email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context: context,
            label: 'Message',
            hint: 'Enter your message',
            maxLines: 4,
            controller: _messageController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoading ? null : _sendEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 12 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Send Message',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(
                        context,
                        mobile: 14,
                        tablet: 15,
                        desktop: 16,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Me',
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
        SizedBox(height: isMobile ? 20 : 24),
        _buildContactItem(
          context: context,
          path: 'gmail.svg',
          title: 'Email',
          value: 'mhdsalih9656@gmail.com',
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          context: context,
          path: 'phone.svg',
          title: 'Phone',
          value: '+91 9656302656',
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          context: context,
          path: 'location.svg',
          title: 'Location',
          value: 'Calicut, Kerala, India-673019',
        ),
      ],
    );
  }

  Widget _buildFollowMeSection(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Me',
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
        SizedBox(height: isMobile ? 20 : 24),
        Row(
          children: [
            // _buildSocialIcon(
            //   context: context,
            //   icon: Icons.facebook,
            //   url: 'https://www.facebook.com/your-profile',
            // ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              context: context,
              imagePath: 'linkedin.svg',
              url: 'https://www.linkedin.com/in/muhammed-salih-t-868b03230/',
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              context: context,
              imagePath: 'github.svg',
              url: 'https://github.com/muhammedSalihT',
            ),
            const SizedBox(width: 16),
            // _buildSocialIcon(
            //   context: context,
            //   icon: Icons.mail,
            //   url: 'mailto:mhdsalih9656@gmail.com',
            // ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required BuildContext context,
    required String imagePath,
    required String url,
  }) {
    return InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: SvgPicture.asset(
        'assets/images/$imagePath',
        height: 40,
        width: 40,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    int maxLines = 1,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    final bool isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
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
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 14,
                tablet: 15,
                desktop: 16,
              ),
              color: Colors.grey[500],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isMobile ? 12 : 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required String path,
    required String title,
    required String value,
  }) {
    // Determine tap action based on title
    void onTap() async {
      if (title == 'Email') {
        final Uri uri = Uri(scheme: 'mailto', path: value);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      } else if (title == 'Phone') {
        final Uri uri = Uri(scheme: 'tel', path: value.replaceAll(' ', ''));
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      } else if (title == 'Location') {
        final Uri uri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(value)}',
        );
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      }
    }

    return InkWell(
      onTap: (title == 'Email' || title == 'Phone' || title == 'Location')
          ? onTap
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/$path',
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 15,
                      desktop: 16,
                    ),
                    color: (title == 'Email' ||
                            title == 'Phone' ||
                            title == 'Location')
                        ? Colors.blue
                        : Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
