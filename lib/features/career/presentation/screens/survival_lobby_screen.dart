import 'package:animate_do/animate_do.dart';
import 'package:cybershow/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SurvivalLobbyScreen extends ConsumerWidget {
  const SurvivalLobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      body: Stack(
        children: [
          // Background Effects (Grid simulation)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.zinc950.withOpacity(0.8),
                    AppTheme.zinc950,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header (Back Button)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => context.go('/home'),
                        icon: const Icon(LucideIcons.arrowLeft,
                            size: 20, color: AppTheme.zinc400),
                        label: Text('Voltar',
                            style: GoogleFonts.inter(
                                color: AppTheme.zinc400,
                                fontWeight: FontWeight.w500)),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.zinc400,
                        ).copyWith(
                          overlayColor:
                              MaterialStateProperty.all(Colors.white10),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Avatar Section
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Glow
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primaryCyan.withOpacity(0.2),
                              ),
                            )
                                .animate(
                                    onPlay: (controller) =>
                                        controller.repeat(reverse: true))
                                .blur(
                                    begin: const Offset(0, 0),
                                    end: const Offset(2, 2),
                                    duration: 2.seconds),

                            // Rotating Ring
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        AppTheme.primaryCyan.withOpacity(0.3),
                                    width: 1),
                              ),
                            )
                                .animate(
                                    onPlay: (controller) => controller.repeat())
                                .rotate(duration: 10.seconds),

                            // Inner Circle
                            Container(
                              width: 130,
                              height: 130,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [AppTheme.zinc800, Colors.black],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'YOU',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Badge
                            Positioned(
                              bottom: -16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                    color: AppTheme.zinc900,
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: AppTheme.primaryCyan),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryCyan
                                            .withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      )
                                    ]),
                                child: Text(
                                  'AURA NÍVEL 5',
                                  style: GoogleFonts.orbitron(
                                    color: AppTheme.primaryCyan,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 60),

                        // Title
                        FadeInUp(
                          child: Text(
                            'Modo Sobrevivência',
                            style: GoogleFonts.orbitron(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Chegue o mais longe possível para evoluir sua Aura. 3 erros e você está fora.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppTheme.zinc400,
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Sistema Vital Box
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.zinc900.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.05)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: List.generate(
                                    3,
                                    (i) => const Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: Icon(LucideIcons.shield,
                                              color: AppTheme.primaryPink,
                                              size: 24),
                                        )),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                  width: 1,
                                  height: 24,
                                  color: AppTheme.zinc700),
                              const SizedBox(width: 16),
                              Text(
                                'SISTEMA VITAL',
                                style: GoogleFonts.sourceCodePro(
                                    color: AppTheme.zinc400,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 60),

                        // Start Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 240, 255, 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                )
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  AppTheme.primaryCyan,
                                  AppTheme.primaryPurple
                                ],
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => context.go('/quiz'),
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'INICIAR SISTEMA',
                                        style: GoogleFonts.orbitron(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2),
                                      ),
                                      const SizedBox(width: 12),
                                      const Icon(LucideIcons.play,
                                          color: Colors.white, size: 20)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
