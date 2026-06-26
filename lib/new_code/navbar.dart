import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/portfolio_data.dart';
import 'package:saim_portfolio/new_code/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _activeIndex = 0;
  bool _isScrolled = false;
  bool _userTapped = false;

  // Cache section offsets so we don't call findRenderObject on every scroll frame
  final List<double> _sectionOffsets = [];
  bool _offsetsCached = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
    // Cache offsets after first frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) => _cacheOffsets());
  }

  void _cacheOffsets() {
    _sectionOffsets.clear();
    for (final key in widget.sectionKeys) {
      final ctx = key.currentContext;
      if (ctx == null) {
        _sectionOffsets.add(0);
        continue;
      }
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) {
        _sectionOffsets.add(0);
        continue;
      }
      // Get absolute Y position in the scroll view
      final pos =
          box.localToGlobal(Offset.zero).dy + widget.scrollController.offset;
      _sectionOffsets.add(pos);
    }
    _offsetsCached = true;
  }

  void _onScroll() {
    final offset = widget.scrollController.offset;

    // Navbar background — simple bool flip, very cheap
    final scrolled = offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }

    if (_userTapped) return;
    if (!_offsetsCached) return;

    // Trigger line: 64 navbar + 100 lookahead
    final trigger = offset + 164.0;
    int newIndex = 0;
    for (int i = 0; i < _sectionOffsets.length; i++) {
      if (trigger >= _sectionOffsets[i]) newIndex = i;
    }

    if (newIndex != _activeIndex) {
      setState(() => _activeIndex = newIndex);
    }
  }

  void _scrollTo(int index) {
    setState(() {
      _activeIndex = index;
      _userTapped = true;
    });

    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx == null) return;

    // Use animateTo with cached offset — much faster than ensureVisible
    if (_offsetsCached && index < _sectionOffsets.length) {
      final target = (_sectionOffsets[index] - 64).clamp(
        0.0,
        widget.scrollController.position.maxScrollExtent,
      );
      widget.scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _userTapped = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMob = Responsive.isMobile(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.background.withValues(alpha: 0.97)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppColors.border : Colors.transparent,
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padH(context),
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _scrollTo(0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                'MS.',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 1,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.3),

          if (!isMob)
            Row(
              children: [
                ...PortfolioData.navItems.asMap().entries.map((e) {
                  final active = e.key == _activeIndex;
                  return GestureDetector(
                    onTap: () => _scrollTo(e.key),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(left: 28),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: active
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: active
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: active
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          child: Text(e.value),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(width: 28),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(AppStrings.cvUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Download CV',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms, delay: 150.ms)
          else
            IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.textPrimary,
              ),
              onPressed: () => _showMenu(context),
            ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...PortfolioData.navItems.asMap().entries.map(
              (e) => ListTile(
                leading: Icon(
                  Icons.chevron_right_rounded,
                  color: e.key == _activeIndex
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  size: 18,
                ),
                title: Text(
                  e.value,
                  style: GoogleFonts.inter(
                    color: e.key == _activeIndex
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: e.key == _activeIndex
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _scrollTo(e.key);
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
