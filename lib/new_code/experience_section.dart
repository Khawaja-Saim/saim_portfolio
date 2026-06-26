import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/portfolio_data.dart';
import 'package:saim_portfolio/new_code/responsive.dart';
import 'section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.padH(context);
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'MY JOURNEY', title: 'Work Experience'),
          const SizedBox(height: 40),
          ...PortfolioData.experiences.asMap().entries.map(
            (e) => _ExperienceCard(
              exp: e.value,
              index: e.key,
              isLast: e.key == PortfolioData.experiences.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final dynamic exp;
  final int index;
  final bool isLast;
  const _ExperienceCard({
    required this.exp,
    required this.index,
    required this.isLast,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: widget.index == 0
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.4),
                shape: BoxShape.circle,
                boxShadow: widget.index == 0
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ]
                    : [],
              ),
            ),
            if (!widget.isLast)
              Container(
                width: 1,
                height: 160,
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
          ],
        ),
        const SizedBox(width: 20),
        // Card
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child:
                AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.exp.company,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.exp.role,
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.2,
                                        ),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Text(
                                      widget.exp.period,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Icon(
                                    _expanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    color: AppColors.textSecondary,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.exp.description,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              height: 1.7,
                            ),
                          ),
                          if (_expanded) ...[
                            const SizedBox(height: 16),
                            const Divider(color: AppColors.border, height: 1),
                            const SizedBox(height: 16),
                            ...List<Widget>.from(
                              (widget.exp.achievements as List<String>)
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) =>
                                        Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 6,
                                                    height: 6,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color:
                                                              AppColors.primary,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      e.value,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .textPrimary,
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .animate(delay: (e.key * 80).ms)
                                            .fadeIn()
                                            .slideX(begin: -0.2),
                                  ),
                            ),
                          ],
                        ],
                      ),
                    )
                    .animate(delay: (widget.index * 200).ms)
                    .fadeIn(duration: 500.ms)
                    .slideX(begin: 0.2),
          ),
        ),
      ],
    );
  }
}
