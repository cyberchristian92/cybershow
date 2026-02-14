import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cybershow/features/career/domain/question_model.dart';

// State to hold the current game status
class GameState {
  final int currentQuestionIndex;
  final int score;
  final int lives;
  final int maxLives;
  final bool isGameOver;
  final bool isWon;
  final List<Question> questions;

  const GameState({
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.lives = 3,
    this.maxLives = 3,
    this.isGameOver = false,
    this.isWon = false,
    this.questions = const [],
  });

  GameState copyWith({
    int? currentQuestionIndex,
    int? score,
    int? lives,
    bool? isGameOver,
    bool? isWon,
    List<Question>? questions,
  }) {
    return GameState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      maxLives: this.maxLives,
      isGameOver: isGameOver ?? this.isGameOver,
      isWon: isWon ?? this.isWon,
      questions: questions ?? this.questions,
    );
  }
}

class GameController extends StateNotifier<GameState> {
  GameController() : super(const GameState(questions: []));

  void startGame() {
    // Load questions (In a real app, this would come from a repository)
    state = GameState(questions: Question.mockQuestions, lives: 3, score: 0);
  }

  void answerQuestion(int selectedIndex) {
    if (state.isGameOver) return;

    final currentQuestion = state.questions[state.currentQuestionIndex];
    final isCorrect = selectedIndex == currentQuestion.correctOptionIndex;

    if (isCorrect) {
      final nextIndex = state.currentQuestionIndex + 1;
      final isWon = nextIndex >= state.questions.length;

      state = state.copyWith(
        score: state.score +
            (100 * (state.currentQuestionIndex + 1)), // Simple scoring
        currentQuestionIndex: isWon ? state.currentQuestionIndex : nextIndex,
        isWon: isWon,
        isGameOver: isWon,
      );
    } else {
      final newLives = state.lives - 1;
      state = state.copyWith(
        lives: newLives,
        isGameOver: newLives <= 0,
      );
    }
  }

  void useLifelineHack() {
    // Implement logic to remove wrong answers visually
  }
}

final gameControllerProvider =
    StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});
