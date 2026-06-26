import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sending = false;

  Future<void> _sendEmail() async {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _msgCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all required fields',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _sending = true);
    final subject = Uri.encodeComponent(
      _subjectCtrl.text.isEmpty ? 'Portfolio Inquiry' : _subjectCtrl.text,
    );
    final body = Uri.encodeComponent(
      'Hi, I am ${_nameCtrl.text}.\n\n${_msgCtrl.text}\n\nReply to: ${_emailCtrl.text}',
    );
    final uri = Uri.parse(
      'mailto:${AppStrings.email}?subject=$subject&body=$body',
    );
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _sending = false);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open email app. Please email: ${AppStrings.email}',
              style: GoogleFonts.inter(),
            ),
            backgroundColor: AppColors.surface,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied: $text',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: AppColors.primary.withValues(alpha: .9),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.padH(context);
    final isMob = Responsive.isMobile(context);
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'GET IN TOUCH', title: 'Contact Me'),
          const SizedBox(height: 40),
          isMob
              ? Column(
                  children: [
                    _buildInfoCol(context),
                    const SizedBox(height: 32),
                    _buildForm(context),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildInfoCol(context)),
                    const SizedBox(width: 40),
                    Expanded(flex: 2, child: _buildForm(context)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildInfoCol(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's work together!",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Have a project in mind or want to hire me? Send a message and I\'ll get back to you within 24 hours.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        _ContactInfoTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: AppStrings.email,
          onTap: () => _copyToClipboard(AppStrings.email),
        ),
        const SizedBox(height: 12),
        _ContactInfoTile(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: AppStrings.phone,
          onTap: () => _copyToClipboard(AppStrings.phone),
        ),
        const SizedBox(height: 12),
        _ContactInfoTile(
          icon: Icons.link,
          label: 'LinkedIn',
          value: 'linkedin.com/in/muhammadsaim',
          onTap: () => _openUrl(AppStrings.linkedin),
        ),
        const SizedBox(height: 12),
        _ContactInfoTile(
          icon: Icons.code,
          label: 'GitHub',
          value: 'github.com/muhammadsaim',
          onTap: () => _openUrl(AppStrings.github),
        ),
        const SizedBox(height: 32),
        Text(
          'Tap to copy or open',
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2);
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _FormField(
                  ctrl: _nameCtrl,
                  hint: 'Your Name *',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _FormField(
                  ctrl: _emailCtrl,
                  hint: 'Your Email *',
                  icon: Icons.email_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _FormField(ctrl: _subjectCtrl, hint: 'Subject', icon: Icons.subject),
          const SizedBox(height: 16),
          _FormField(
            ctrl: _msgCtrl,
            hint: 'Your Message *',
            icon: Icons.message_outlined,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: _sending ? null : _sendEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: _sending
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.background,
                        ),
                      )
                    : Text(
                        'Send Message',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideX(begin: 0.2);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }
}

class _ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  const _ContactInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.copy_rounded, color: AppColors.textSecondary, size: 14),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final IconData icon;
  final int maxLines;
  const _FormField({
    required this.ctrl,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: GoogleFonts.inter(fontSize: 13, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
        prefixIcon: maxLines == 1
            ? Icon(icon, color: AppColors.textSecondary, size: 18)
            : null,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
