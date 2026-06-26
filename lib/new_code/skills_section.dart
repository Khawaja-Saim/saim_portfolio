import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/responsive.dart';

import 'section_header.dart';

// --- Skill Model (Structure intact as requested) ---
class SkillModel {
  final String name;
  final String icon; // Kept empty for structure compatibility
  final double level; // Kept 0.0 for structure compatibility
  final String category;

  const SkillModel({
    required this.name,
    required this.icon,
    required this.level,
    required this.category,
  });
}

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  // Organized professional categories
  final List<String> _categories = [
    'All',
    'Core Development',
    'Architecture & Opt.',
    'State Management',
    'Backend & DB',
    'Advanced Features',
  ];

  String _selectedCategory = 'All';

  // Complete updated skill list (Aapki skills + premium industry additions)
  final List<SkillModel> _allSkills = [
    // --- Core Development ---
    const SkillModel(
      name: 'Mobile Application Development',
      icon: '',
      level: 0.0,
      category: 'Core Development',
    ),
    const SkillModel(
      name: 'Flutter',
      icon: '',
      level: 0.0,
      category: 'Core Development',
    ),
    const SkillModel(
      name: 'Dart Programming',
      icon: '',
      level: 0.0,
      category: 'Core Development',
    ),
    const SkillModel(
      name: 'Responsive UI Design',
      icon: '',
      level: 0.0,
      category: 'Core Development',
    ),
    const SkillModel(
      name: 'UI/UX Design',
      icon: '',
      level: 0.0,
      category: 'Core Development',
    ),

    // --- Architecture & Optimization ---
    const SkillModel(
      name: 'Clean Architecture',
      icon: '',
      level: 0.0,
      category: 'Architecture & Opt.',
    ),
    const SkillModel(
      name: 'App Performance Optimization',
      icon: '',
      level: 0.0,
      category: 'Architecture & Opt.',
    ),
    // const SkillModel(
    //   name: 'BLoC / Cubit Pattern',
    //   icon: '',
    //   level: 0.0,
    //   category: 'Architecture & Opt.',
    // ), // Added for seniority depth
    const SkillModel(
      name: 'GitHub / Git Workflow',
      icon: '',
      level: 0.0,
      category: 'Architecture & Opt.',
    ),
    const SkillModel(
      name: 'CI/CD Pipelines (GitHub Actions)',
      icon: '',
      level: 0.0,
      category: 'Architecture & Opt.',
    ), // Added for premium edge

    const SkillModel(
      name: 'GetX',
      icon: '',
      level: 0.0,
      category: 'State Management',
    ),
    const SkillModel(
      name: 'Provider',
      icon: '',
      level: 0.0,
      category: 'State Management',
    ),
    const SkillModel(
      name: 'Riverpod',
      icon: '',
      level: 0.0,
      category: 'State Management',
    ),

    // --- Backend & Databases ---
    const SkillModel(
      name: 'API Integration',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ),
    const SkillModel(
      name: 'RESTful APIs',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ),
    const SkillModel(
      name: 'Firebase Integration',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ),
    const SkillModel(
      name: 'Supabase',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ),
    const SkillModel(
      name: 'SQLite',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ),
    const SkillModel(
      name: 'SharedPreferences',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ),
    const SkillModel(
      name: 'GraphQL',
      icon: '',
      level: 0.0,
      category: 'Backend & DB',
    ), // Added premium query language
    // --- Advanced Features & Cloud ---
    const SkillModel(
      name: 'AI Integration (LLMs & Vision)',
      icon: '',
      level: 0.0,
      category: 'Advanced Features',
    ),
    const SkillModel(
      name: 'Hugging Face Apis',
      icon: '',
      level: 0.0,
      category: 'Advanced Features',
    ),
    const SkillModel(
      name: 'Push Notifications',
      icon: '',
      level: 0.0,
      category: 'Advanced Features',
    ),
    const SkillModel(
      name: 'In-App Purchases (Stripe / RevenueCat)',
      icon: '',
      level: 0.0,
      category: 'Advanced Features',
    ),
    const SkillModel(
      name: 'Play Store Deployment',
      icon: '',
      level: 0.0,
      category: 'Advanced Features',
    ),
    const SkillModel(
      name: 'App Store Deployment',
      icon: '',
      level: 0.0,
      category: 'Advanced Features',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.padH(context);

    // Filtering mechanism based on tab selection
    final filteredSkills = _selectedCategory == 'All'
        ? _allSkills
        : _allSkills.where((s) => s.category == _selectedCategory).toList();

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(label: 'MY EXPERTISE', title: 'Skills & Technologies'),
          const SizedBox(height: 36),

          // --- Category Tabs Selector ---
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 12, bottom: 8),
                  child: InkWell(
                    onTap: () => setState(() => _selectedCategory = category),
                    borderRadius: BorderRadius.circular(30),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 36),

          // --- Layout: Clean auto-wrapping chip architecture ---
          KeyedSubtree(
            key: ValueKey(
              _selectedCategory,
            ), // Smoothly re-animates items on category switch
            child: Wrap(
              spacing: 12,
              runSpacing: 14,
              children: List.generate(
                filteredSkills.length,
                (i) => _MinimalSkillChip(skill: filteredSkills[i], index: i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MinimalSkillChip extends StatefulWidget {
  final SkillModel skill;
  final int index;
  const _MinimalSkillChip({required this.skill, required this.index});

  @override
  State<_MinimalSkillChip> createState() => _MinimalSkillChipState();
}

class _MinimalSkillChipState extends State<_MinimalSkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.primary.withValues(alpha: 0.06)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(
                    6,
                  ), // Sharp modern tech aesthetic
                  border: Border.all(
                    color: _hovered ? AppColors.primary : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.skill.name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _hovered ? AppColors.primary : AppColors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                ),
              )
              .animate(
                delay: (widget.index * 25).ms,
              ) // Super crisp cascade effect
              .fadeIn(duration: 250.ms)
              .slideX(begin: 0.04, curve: Curves.easeOut),
    );
  }
}
