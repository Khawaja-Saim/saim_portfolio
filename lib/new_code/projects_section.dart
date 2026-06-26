import 'package:vector_math/vector_math_64.dart' show Matrix4, Vector3;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/portfolio_data.dart';
import 'package:saim_portfolio/new_code/portfolio_models.dart';
import 'package:saim_portfolio/new_code/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.projectCols(context);
    final padH = Responsive.padH(context);
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'MY WORK', title: 'Featured Projects'),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.78,
            ),
            itemCount: PortfolioData.projects.length,
            itemBuilder: (_, i) =>
                _ProjectCard(project: PortfolioData.projects[i], index: i),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                // transform: Matrix4.identity()
                //   ..translate(0.0, _hovered ? -6.0 : 0.0),
                transform: Matrix4.identity()
                  ..translateByVector3(
                    Vector3(0.0, _hovered ? -6.0 : 0.0, 0.0),
                  ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.primary.withValues(alpha: 0.4)
                        : AppColors.border,
                    width: 0.5,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            blurRadius: 24,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: p.thumbColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        // child: Text(
                        //   p.emoji,
                        //   style: const TextStyle(fontSize: 48),
                        // ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(p.emoji, width: 64, height: 64),
                        ),
                      ),
                    ),
                    // Body
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.title,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Text(
                                p.description,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                  height: 1.6,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Tags
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: p.tags
                                  .map(
                                    (tag) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.2,
                                          ),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        tag,
                                        style: GoogleFonts.inter(
                                          fontSize: 10,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            if (p.storeLabel != null) ...[
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => p.storeUrl != null
                                    ? _openUrl(p.storeUrl!)
                                    : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        p.storeLabel!.contains('Play')
                                            ? '▶ '
                                            : '🍎 ',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      Text(
                                        p.storeLabel!,
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: (widget.index * 80).ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2),
    );
  }
}
