import 'package:animate_do/animate_do.dart';
import 'package:cybershow/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SurvivalResultScreen extends StatefulWidget {
  final int score;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  const SurvivalResultScreen({
    super.key,
    required this.score,
    required this.onRestart,
    required this.onHome,
  });

  @override
  State<SurvivalResultScreen> createState() => _SurvivalResultScreenState();
}

class _SurvivalResultScreenState extends State<SurvivalResultScreen> {
  bool showNameInput = false;
  bool saved = false;
  final TextEditingController _nameController = TextEditingController();

  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_nameController.text.trim().isEmpty) return;

    // Simulate save
    setState(() {
      saved = true;
    });

    // TODO: Implement actual storage (SharedPreferences)

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) widget.onHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWin = widget.score > 0;

    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      body: Stack(
        children: [
          // Background Noise/Glow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    isWin
                        ? AppTheme.primaryCyan.withOpacity(0.15)
                        : AppTheme.destructive.withOpacity(0.15),
                    AppTheme.zinc950,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    ZoomIn(
                      duration: const Duration(milliseconds: 600),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isWin
                              ? AppTheme.primaryCyan.withOpacity(0.1)
                              : AppTheme.destructive.withOpacity(0.1),
                          border: Border.all(
                            color: isWin
                                ? AppTheme.primaryCyan
                                : AppTheme.destructive,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isWin
                                  ? AppTheme.primaryCyan.withOpacity(0.4)
                                  : AppTheme.destructive.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          isWin ? LucideIcons.trophy : LucideIcons.alertOctagon,
                          size: 48,
                          color: isWin
                              ? AppTheme.primaryCyan
                              : AppTheme.destructive,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        isWin ? 'CHECKPOINT ALCANÇADO' : 'DESCONEXÃO',
                        style: GoogleFonts.orbitron(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isWin ? Colors.white : AppTheme.destructive,
                          shadows: [
                            Shadow(
                              color: isWin
                                  ? AppTheme.primaryCyan.withOpacity(0.5)
                                  : AppTheme.destructive.withOpacity(0.5),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        isWin
                            ? 'Sua evolução foi registrada.'
                            : 'Suas defesas falharam.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppTheme.zinc400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Aura Score
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 48),
                        decoration: BoxDecoration(
                          color: AppTheme.zinc900.withOpacity(0.6),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'AURA ATINGIDA',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                letterSpacing: 3,
                                color: AppTheme.zinc500,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${widget.score}',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: isWin
                                            ? AppTheme.primaryCyan
                                                .withOpacity(0.5)
                                            : AppTheme.destructive
                                                .withOpacity(0.5),
                                        blurRadius: 20,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'AURA',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isWin
                                        ? AppTheme.primaryCyan
                                        : AppTheme.destructive,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Actions / Input
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: saved
                          ? Column(
                              key: const ValueKey('saved'),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: const Icon(LucideIcons.check,
                                      color: Colors.green),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Progresso salvo no ranking!',
                                  style: GoogleFonts.inter(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('Voltando ao menu...',
                                    style: GoogleFonts.inter(
                                        color: AppTheme.zinc500, fontSize: 12)),
                              ],
                            )
                          : showNameInput
                              ? Column(
                                  key: const ValueKey('input'),
                                  children: [
                                    TextField(
                                      controller: _nameController,
                                      autofocus: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: 'Seu nome para o ranking',
                                        hintStyle:
                                            TextStyle(color: AppTheme.zinc600),
                                        filled: true,
                                        fillColor: AppTheme.zinc900,
                                        prefixIcon: Icon(LucideIcons.user,
                                            color: AppTheme.zinc500),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppTheme.zinc800),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppTheme.zinc800),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryCyan),
                                        ),
                                      ),
                                      onSubmitted: (_) => _handleSave(),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: _handleSave,
                                        icon: const Icon(LucideIcons.save),
                                        label: const Text('SALVAR'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.primaryCyan,
                                          foregroundColor: AppTheme.zinc950,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  key: const ValueKey('actions'),
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            showNameInput = true;
                                          });
                                        },
                                        icon: const Icon(LucideIcons.save),
                                        label: const Text('SALVAR PROGRESSO'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.primaryCyan,
                                          foregroundColor: AppTheme.zinc950,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: widget.onRestart,
                                        icon: const Icon(LucideIcons.rotateCcw),
                                        label: Text(isWin
                                            ? 'JOGAR NOVAMENTE'
                                            : 'REINICIAR SISTEMA'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: isWin
                                              ? Colors.white
                                              : AppTheme.destructive,
                                          side: BorderSide(
                                              color: isWin
                                                  ? AppTheme.zinc700
                                                  : AppTheme.destructive),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton.icon(
                                      onPressed: widget.onHome,
                                      icon: const Icon(LucideIcons.home,
                                          size: 16),
                                      label: const Text('Voltar ao Menu'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppTheme.zinc500,
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
