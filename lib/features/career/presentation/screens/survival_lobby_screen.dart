import 'package:animate_do/animate_do.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Sobrevivência'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
                child: Icon(LucideIcons.skull,
                    size: 60, color: theme.colorScheme.secondary),
              ).animate(onPlay: (c) => c.repeat(reverse: true)),
            ),
            const SizedBox(height: 32),

            FadeInUp(
              child: Text(
                'ASCENSÃO DIGITAL',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Você tem 3 vidas. Erre 3 vezes e seja desconectado.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),

            const SizedBox(height: 48),

            // Lives Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(LucideIcons.heart,
                            color: theme.colorScheme.error, size: 32),
                      )),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ref.read(gameControllerProvider.notifier).startGame();
                  context.go('/quiz');
                  // Navigate to actual game screen (TODO: Create Game Screen)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Iniciando Quiz... Boa Sorte!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text('INICIAR EXECUÇÃO'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
