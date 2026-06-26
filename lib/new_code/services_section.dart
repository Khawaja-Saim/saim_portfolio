import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/portfolio_data.dart';
import 'package:saim_portfolio/new_code/responsive.dart';

import 'section_header.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.serviceCols(context);
    final padH = Responsive.padH(context);
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'WHAT I OFFER', title: 'Services'),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            itemCount: PortfolioData.services.length,
            itemBuilder: (_, i) {
              final s = PortfolioData.services[i];
              return _ServiceCard(service: s, index: i);
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final dynamic service;
  final int index;
  const _ServiceCard({required this.service, required this.index});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.primary.withValues(alpha: 0.4)
                        : AppColors.border,
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service.icon,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.service.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.service.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: (widget.index * 100).ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2),
    );
  }
}
