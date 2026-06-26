import 'package:flutter/material.dart';
import 'package:saim_portfolio/new_code/app_images.dart';
import 'package:saim_portfolio/new_code/portfolio_models.dart';

class PortfolioData {
  // Nav items — order must match sectionKeys list in HomeScreen
  static const List<String> navItems = [
    'Home',
    'Skills',
    'Experience',
    'Projects',
    'Services',
    'Contact',
  ];

  static const List<Map<String, String>> stats = [
    {'number': '3+', 'label': 'Years Experience'},
    {'number': '30+', 'label': 'Apps Built'},
    {'number': '2', 'label': 'Companies'},
    {'number': '5', 'label': 'Live on Stores'},
  ];

  static const List<SkillModel> skills = [
    SkillModel(name: 'Flutter', icon: '', level: 1),
    SkillModel(name: 'Dart', icon: '', level: 1),
    SkillModel(name: 'Firebase', icon: '', level: 1),
    SkillModel(name: 'REST APIs', icon: '', level: 1),

    SkillModel(name: 'GetX', icon: '', level: 1),
    SkillModel(name: 'Provider', icon: '', level: 1),
    SkillModel(name: 'Riverpod', icon: '', level: 1),

    SkillModel(name: 'SQLite', icon: '', level: 1),
    SkillModel(name: 'Hive', icon: '', level: 1),

    SkillModel(name: 'Git', icon: '', level: 1),
    SkillModel(name: 'GitHub', icon: '', level: 1),

    SkillModel(name: 'UI/UX', icon: '', level: 1),
    SkillModel(name: 'Figma', icon: '', level: 1),

    SkillModel(name: 'Responsive UI', icon: '', level: 1),

    SkillModel(name: 'Play Store', icon: '', level: 1),
    SkillModel(name: 'App Store', icon: '', level: 1),

    SkillModel(name: 'Firebase Auth', icon: '', level: 1),
    SkillModel(name: 'Cloud Firestore', icon: '', level: 1),

    SkillModel(name: 'Push Notifications', icon: '', level: 1),

    SkillModel(name: 'Google Maps', icon: '', level: 1),

    SkillModel(name: 'Localization', icon: '', level: 1),

    SkillModel(name: 'Payment Gateway', icon: '', level: 1),

    SkillModel(name: 'Animations', icon: '', level: 1),

    SkillModel(name: 'JSON', icon: '', level: 1),

    SkillModel(name: 'Clean Architecture', icon: '', level: 1),

    SkillModel(name: 'MVC', icon: '', level: 1),

    SkillModel(name: 'OpenAI APIs', icon: '', level: 1),

    SkillModel(name: 'Hugging Face', icon: '', level: 1),
  ];
  // static const List<SkillModel> skills = [
  // SkillModel(name: 'Flutter', icon: '📱', level: 0.95),
  // SkillModel(name: 'Dart', icon: '🎯', level: 0.90),
  // SkillModel(name: 'Firebase', icon: '🔥', level: 0.82),
  // SkillModel(name: 'REST APIs', icon: '🌐', level: 0.85),
  // SkillModel(name: 'GetX', icon: '⚡', level: 0.88),
  // // SkillModel(name: 'Bloc/Cubit', icon: '🧱', level: 0.80),
  // SkillModel(name: 'SQLite/Hive', icon: '🗃️', level: 0.75),
  // SkillModel(name: 'Git', icon: '🐙', level: 0.85),
  // SkillModel(name: 'UI/UX', icon: '🎨', level: 0.78),
  // SkillModel(name: 'App Store', icon: '🍎', level: 0.80),
  // SkillModel(name: 'Play Store', icon: '▶️', level: 0.85),
  // SkillModel(name: 'Figma', icon: '🖼️', level: 0.72),

  // ];

  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'Nextwys Software Solution',
      role: 'Senior Flutter Developer',
      period: '2025',
      description:
          "Leading mobile development projects by building scalable cross-platform Flutter apps and collaborating with backend teams for seamless API integration across various industries",
      achievements: [
        'Built 8+ apps ',
        'Led a team of 3 junior developers',
        'Reduced app load time by 40% through code optimization',
        // 'Implemented CI/CD pipelines for automated deployment',
      ],
    ),
    ExperienceModel(
      company: 'Byte Sources Solution',
      role: 'Flutter Developer',
      period: '2023 – 2024',
      description:
          'Learned Flutter development from scratch and quickly progressed to building responsive, scalable mobile applications while delivering client projects professionally.',
      achievements: [
        'Delivered 15+ client projects on time',
        'Implemented complex animations and custom widgets',
        'Worked with REST APIs and Firebase backend',
      ],
    ),
  ];

  static final List<ProjectModel> projects = [
    ProjectModel(
      title: 'MJA: Meditation & Achtsamkeit',
      description:
          "This is a relaxing music and meditation app designed to help users reduce stress, overcome anxiety, improve sleep quality, and achieve a calmer and happier lifestyle through soothing sounds and guided relaxation experiences",
      emoji: AppImages.mjaAppLogo,
      tags: ['Flutter', 'Firebase', 'In-App Purchase', 'GetX'],
      storeLabel: 'Live on Play Store',
      storeUrl:
          'https://play.google.com/store/apps/details?id=com.heikokusters.mindfulness_journey_app&pcampaignid=web_share',
      thumbColor: const Color(0xFF0a2018),
    ),
    ProjectModel(
      title: 'Cognize: Productivity Planner',
      description:
          "Cognize is a simple productivity app to organize your daily life. It lets you add events, notes, reminders, alarms, stopwatch tasks, and upload files like photos and videos. It also includes a secure password-protected folder to keep your private data safe.",
      emoji: AppImages.cognizeAppLogo,
      tags: ['Flutter', 'Firebase', 'GetX', "Push-Notification"],
      storeLabel: 'Live on Play Store',
      storeUrl:
          'https://play.google.com/store/apps/details?id=com.cognizeapp.app&pcampaignid=web_share',
      thumbColor: const Color(0xFF1a0f22),
    ),
    ProjectModel(
      title: 'Salomo',
      description:
          'Salomo is an AI-powered dream companion that helps you record, explore, and understand your dreams. It lets you reflect on symbols, emotions, and thoughts to gain deeper insight into your subconscious mind in a simple and intuitive way.',
      emoji: AppImages.salomoAppLogo,
      tags: ['Flutter', 'Supabase', 'Provider'],
      storeLabel: 'Live on Play Store',
      storeUrl:
          'https://play.google.com/store/apps/details?id=com.dreamsageai.app&pcampaignid=web_share',
      thumbColor: const Color(0xFFffffff),
    ),
    ProjectModel(
      title: 'Earnovate\nDigital Success Toolkit',
      description:
          'Earnovate™ is an all-in-one digital success toolkit designed to help beginners, creators, and entrepreneurs learn how to earn online. It provides AI guides, branding resources, templates, planners, and step-by-step courses to help users create content, build digital products, and grow their online income with confidence.',
      emoji: AppImages.earnovateAppLogo,
      tags: ['Flutter', 'Firebase', 'In-App Purchase', "Getx"],
      storeLabel: 'Live on App Store',

      storeUrl: 'https://apps.apple.com/us/app/earnovate/id6755743036',
      thumbColor: const Color(0xFF1a1a08),
    ),
    ProjectModel(
      title: 'Uni-Social App',
      description:
          // 'Cop Cup is a modern food delivery app that allows users to order food from nearby restaurants based on their location. The app provides a smooth and user-friendly experience with real-time restaurant browsing, fast ordering, and convenient delivery services.',
          "Uni Social App is a modern social media platform where users can create profiles, share stories, upload photos and videos, and interact with others through likes, comments, and shares. Inspired by popular social networking apps, it provides a smooth and engaging experience for connecting and sharing moments with friends and communities.",

      emoji: AppImages.socialAppLogo,
      tags: ['Flutter', 'Getx', 'Firebase'],
      storeLabel: 'Project Video',
      storeUrl:
          'https://drive.google.com/file/d/1XsYQB9YdOgCLDBmcwTopTJPOFyD0EWPV/view?usp=sharing',
      thumbColor: const Color(0xFF08081a),
    ),
  ];

  static const List<ServiceModel> services = [
    ServiceModel(
      title: 'Mobile App Development',
      description:
          'End-to-end Flutter apps for iOS & Android with clean architecture and smooth performance.',
      icon: '📱',
    ),
    ServiceModel(
      title: 'UI/UX Implementation',
      description:
          'Pixel-perfect implementation of Figma/Adobe XD designs with beautiful animations.',
      icon: '🎨',
    ),
    ServiceModel(
      title: 'API Integration',
      description:
          'Seamless REST & GraphQL API integration, Firebase backend, and third-party services.',
      icon: '🔗',
    ),
    ServiceModel(
      title: 'App Maintenance',
      description:
          'Bug fixing, performance optimization, and feature additions for existing Flutter apps.',
      icon: '🔧',
    ),
  ];
}
