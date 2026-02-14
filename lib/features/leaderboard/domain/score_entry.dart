import 'dart:convert';

class ScoreEntry {
  final String name;
  final int score;
  final DateTime date;

  ScoreEntry({
    required this.name,
    required this.score,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  factory ScoreEntry.fromMap(Map<String, dynamic> map) {
    return ScoreEntry(
      name: map['name'] ?? '',
      score: map['score']?.toInt() ?? 0,
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreEntry.fromJson(String source) =>
      ScoreEntry.fromMap(json.decode(source));
}
