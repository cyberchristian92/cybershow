import 'package:shared_preferences/shared_preferences.dart';
import 'package:cybershow/features/leaderboard/domain/score_entry.dart';

class ScoreRepository {
  static const String _key = 'leaderboard_scores';

  Future<void> saveScore(String name, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> scoresJson = prefs.getStringList(_key) ?? [];

    final newEntry = ScoreEntry(
      name: name,
      score: score,
      date: DateTime.now(),
    );

    scoresJson.add(newEntry.toJson());
    await prefs.setStringList(_key, scoresJson);
  }

  Future<List<ScoreEntry>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> scoresJson = prefs.getStringList(_key) ?? [];

    final List<ScoreEntry> scores =
        scoresJson.map((json) => ScoreEntry.fromJson(json)).toList();

    // Sort by score descending
    scores.sort((a, b) => b.score.compareTo(a.score));

    return scores;
  }
}
