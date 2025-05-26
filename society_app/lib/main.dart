import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Only enable in debug mode
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Society Marketplace',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF009688),
          primary: const Color(0xFF009688),
          secondary: const Color(0xFFFFC107),
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
