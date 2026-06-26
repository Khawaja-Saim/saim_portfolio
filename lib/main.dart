import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saim_portfolio/new_code/app_constants.dart';
import 'package:saim_portfolio/new_code/home_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhammad Saim – Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.surface,
          // surface: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.border),
          radius: const Radius.circular(4),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
