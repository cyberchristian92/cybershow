import 'package:cybershow/core/theme/app_theme.dart';
import 'package:cybershow/features/leaderboard/data/score_repository.dart';
import 'package:cybershow/features/leaderboard/domain/score_entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Icon(LucideIcons.trophy,
                      color: AppTheme.primaryCyan, size: 32),
                  const SizedBox(width: 16),
                  Text(
                    'RANKING GLOBAL',
                    style: GoogleFonts.orbitron(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ScoreEntry>>(
                future: ScoreRepository().getScores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao carregar ranking',
                          style: TextStyle(color: AppTheme.destructive)),
                    );
                  }

                  final scores = snapshot.data ?? [];

                  if (scores.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.ghost,
                              size: 64, color: AppTheme.zinc700),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum registro encontrado',
                            style: GoogleFonts.inter(
                              color: AppTheme.zinc500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: scores.length,
                    itemBuilder: (context, index) {
                      final score = scores[index];
                      final isTop3 = index < 3;
                      final rankColor = index == 0
                          ? const Color(0xFFFFD700) // Gold
                          : index == 1
                              ? const Color(0xFFC0C0C0) // Silver
                              : index == 2
                                  ? const Color(0xFFCD7F32) // Bronze
                                  : AppTheme.zinc500;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.zinc900,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isTop3
                                ? rankColor.withOpacity(0.5)
                                : AppTheme.zinc800,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isTop3
                                    ? rankColor.withOpacity(0.1)
                                    : AppTheme.zinc800,
                              ),
                              child: Text(
                                '#${index + 1}',
                                style: GoogleFonts.orbitron(
                                  fontWeight: FontWeight.bold,
                                  color: rankColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    score.name,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy HH:mm')
                                        .format(score.date),
                                    style: GoogleFonts.inter(
                                      color: AppTheme.zinc500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${score.score}',
                                  style: GoogleFonts.orbitron(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryCyan,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('AURA',
                                    style: GoogleFonts.inter(
                                        fontSize: 10, color: AppTheme.zinc600)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
