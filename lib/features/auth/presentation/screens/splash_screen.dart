import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    const cyberCyan = Color(0xFF00F0FF);
    const cyberPurple = Color(0xFFBD00FF);

    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container with Glitch Effect
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: cyberCyan.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.2, 1.2),
                    duration: 2.seconds),
                const Icon(
                  LucideIcons.shield,
                  size: 80,
                  color: Colors.white,
                )
                    .animate(onPlay: (c) => c.repeat())
                    .shake(
                        hz: 8,
                        curve: Curves.easeInOutCubic,
                        duration: 1000.ms) // Simulating glitch shake
                    .tint(color: cyberPurple, duration: 200.ms),
              ],
            ),

            const SizedBox(height: 32),

            // Text with Orbitron Font
            Column(
              children: [
                Text(
                  'CYBER',
                  style: GoogleFonts.orbitron(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4.0,
                    height: 0.9,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: -0.2, end: 0),
                Text(
                  'SHOW',
                  style: GoogleFonts.orbitron(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .transparent, // Gradient text trick or just colored
                  ).copyWith(color: cyberCyan),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: 0.2, end: 0)
                    .shimmer(duration: 1500.ms, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
