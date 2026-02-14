import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors from React Theme (approximate mapping)
    const cyberCyan = Color(0xFF00F0FF);
    const cyberPurple = Color(0xFFBD00FF);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by parent/main
      body: Stack(
        children: [
          // Header Background (Sticky effect simulated)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.8),
                border: Border(
                    bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: const [
                            TextSpan(text: 'Olá, '),
                            TextSpan(
                                text: 'CyberAgent',
                                style: TextStyle(color: cyberCyan)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(LucideIcons.zap,
                              size: 12, color: cyberPurple),
                          const SizedBox(width: 4),
                          Text(
                            'Nível 5',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [cyberCyan, cyberPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.user,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 130), // Offset for header
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Career Mode Card (Marked as Em Breve per user request)
                FadeInUp(
                  child: _CyberCard(
                    title: 'Sobrevivência',
                    badge: 'MODO CARREIRA',
                    subtitle:
                        'Tente acertar o máximo que conseguir e evolua sua Aura.',
                    icon: LucideIcons.trophy,
                    accentColor: cyberCyan,
                    isLocked: false, // "Em Breve"
                    onTap: () {
                      context.go('/survival');
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Multiplayer Card
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Opacity(
                    opacity: 0.6,
                    child: _CyberCard(
                      title: 'Multijogador',
                      badge: 'COMUNIDADE',
                      subtitle: 'Crie e jogue desafios de outros usuários.',
                      icon: LucideIcons.users,
                      accentColor: cyberPurple,
                      isLocked: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Hub da Comunidade em breve...')),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Quick Access Link
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF09090B), // cyber-dark
                      border: Border.all(color: Colors.grey[800]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          // Open LinkTree logic
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEC4899)
                                          .withOpacity(0.1), // cyber-pink
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(LucideIcons.zap,
                                        color: Color(0xFFEC4899), size: 20),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Mais Cybersecurity',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Acesse mais conteúdos do criador',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(LucideIcons.externalLink,
                                  size: 20, color: Colors.grey[600]),
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
        ],
      ),
    );
  }
}

class _CyberCard extends StatelessWidget {
  final String title;
  final String badge;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final bool isLocked;
  final VoidCallback onTap;

  const _CyberCard({
    required this.title,
    required this.badge,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    this.isLocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Glow Effect
          if (!isLocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      accentColor.withOpacity(0.4),
                      accentColor.withOpacity(0.1)
                    ],
                  ),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .blur(begin: const Offset(10, 10), end: const Offset(20, 20)),
            ),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF18181B).withOpacity(0.8), // cyber-input/80
              border: Border.all(color: accentColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.2),
                        border: Border.all(color: accentColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (isLocked) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          border: Border.all(color: Colors.grey[700]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          children: [
                            Icon(LucideIcons.lock,
                                size: 12, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'EM BREVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.orbitron(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isLocked ? Colors.grey[400] : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      icon,
                      size: 64,
                      color: isLocked
                          ? Colors.grey[700]
                          : accentColor.withOpacity(0.8),
                    ),
                  ],
                ),
                if (!isLocked) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'JOGAR AGORA',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(LucideIcons.play, size: 16, color: accentColor),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
