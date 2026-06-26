import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/app_images.dart';
import 'package:saim_portfolio/new_code/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMob = Responsive.isMobile(context);
    final isTab = Responsive.isTablet(context);
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padH(context),
        vertical: isMob ? 60 : 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.background, Color(0xFF0b1e18)],
        ),
      ),
      child: (isMob || isTab)
          ? Column(
              children: [
                _avatar(context),
                const SizedBox(height: 40),
                _text(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: _text(context)),
                const SizedBox(width: 60),
                _avatar(context),
              ],
            ),
    );
  }

  Widget _text(BuildContext context) {
    final isMob = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        _AvailableBadge()
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.3),
        const SizedBox(height: 24),
        // Name
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hi, I'm\n",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: Responsive.heroFont(context),
                  fontWeight: FontWeight.w300,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              TextSpan(
                text: 'Muhammad ',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: Responsive.heroFont(context),
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  height: 1.15,
                ),
              ),
              TextSpan(
                text: 'Saim',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: Responsive.heroFont(context),
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.2),

        const SizedBox(height: 16),

        // Typewriter role
        Row(
          children: [
            Text(
              '> ',
              style: GoogleFonts.firaCode(
                fontSize: 17,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Flutter Developer',
                  textStyle: GoogleFonts.firaCode(
                    fontSize: 17,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 75),
                ),
                TypewriterAnimatedText(
                  'Mobile App Specialist',
                  textStyle: GoogleFonts.firaCode(
                    fontSize: 17,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 75),
                ),
                TypewriterAnimatedText(
                  '3+ Years Experience',
                  textStyle: GoogleFonts.firaCode(
                    fontSize: 17,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 75),
                ),
                TypewriterAnimatedText(
                  'iOS & Android Expert',
                  textStyle: GoogleFonts.firaCode(
                    fontSize: 17,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 75),
                ),
              ],
              repeatForever: true,
              pause: const Duration(milliseconds: 1500),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms),

        const SizedBox(height: 24),

        Text(
          AppStrings.heroDesc,
          style: GoogleFonts.inter(
            fontSize: isMob ? 14 : 15,
            color: AppColors.textSecondary,
            height: 1.8,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.2),

        const SizedBox(height: 36),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroBtn(label: 'View My Work', primary: true, onTap: onViewWork),
            _HeroBtn(label: 'Contact Me', primary: false, onTap: onContact),
            _HeroBtn(
              label: 'Download CV',
              primary: false,
              onTap: () async {
                final uri = Uri.parse(AppStrings.cvUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _avatar(BuildContext context) {
    final isMob = Responsive.isMobile(context);
    final size = isMob ? 160.0 : 220.0;
    return Stack(
          alignment: Alignment.center,
          children: [
            // Glow ring
            Container(
                  width: size + 30,
                  height: size + 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  duration: 3000.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.25),
                    AppColors.primary.withValues(alpha: 0.05),
                  ],
                ),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  width: 2,
                ),

                // image: DecorationImage(
                //   image: AssetImage(AppImages.myImage),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000),
                child: Image.asset(AppImages.myImage, fit: BoxFit.cover),
              ),

              // child: Center(
              //   child: Text(
              //     'MS',
              //     style: GoogleFonts.spaceGrotesk(
              //       fontSize: isMob ? 52 : 72,
              //       fontWeight: FontWeight.w800,
              //       color: AppColors.primary,
              //     ),
              //   ),
              // ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 300.ms)
        .scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOut);
  }
}

class _AvailableBadge extends StatefulWidget {
  @override
  State<_AvailableBadge> createState() => _AvailableBadgeState();
}

class _AvailableBadgeState extends State<_AvailableBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 1.0, end: 0.25).animate(_ctrl);
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _anim,
            builder: (s, ww) => Opacity(
              opacity: _anim.value,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for work',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}

class _HeroBtn extends StatefulWidget {
  final String label;
  final bool primary;
  final VoidCallback onTap;
  const _HeroBtn({
    required this.label,
    required this.primary,
    required this.onTap,
  });

  @override
  State<_HeroBtn> createState() => _HeroBtnState();
}

class _HeroBtnState extends State<_HeroBtn> {
  bool _hov = false;

  @override
  Widget build(BuildContext ctx) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hov ? AppColors.primaryDark : AppColors.primary)
                : (_hov
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.primary
                  ? Colors.transparent
                  : AppColors.primary.withValues(alpha: 0.4),
              width: 0.5,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: widget.primary ? AppColors.background : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
