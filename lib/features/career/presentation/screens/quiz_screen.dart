import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cybershow/core/theme/app_theme.dart';
import 'package:cybershow/features/career/data/questions_db.dart';
import 'package:cybershow/features/career/domain/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Questions are now loaded from lib/features/career/data/questions_db.dart
  late final List<Question> _questions;

  static const int TIMER_SECONDS = 15;

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _lives = 3;
  int _timer = TIMER_SECONDS;
  Timer? _timerController;

  bool _isAnswered = false;
  bool _showExplanation = false;
  int? _selectedOptionIndex;
  bool? _isCorrect;

  // Lifelines
  bool _hasHack = true;
  bool _hasSkip = true;
  List<int> _hiddenOptions = [];

  @override
  void initState() {
    super.initState();
    // Create a copy e shuffle it
    _questions = List.from(questionsDatabase)..shuffle();
    _startTimer();
  }

  @override
  void dispose() {
    _timerController?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = TIMER_SECONDS;
    _timerController?.cancel();
    _timerController = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        setState(() {
          _timer--;
        });
      } else {
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    if (_isAnswered || _showExplanation) return;
    _timerController?.cancel();
    setState(() {
      _isAnswered = true;
      _isCorrect = false;
      _selectedOptionIndex = null;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showExplanation = true;
          _lives--;
        });
      }
    });
  }

  void _handleAnswer(int selectedIndex) {
    if (_isAnswered || _showExplanation) return;
    _timerController?.cancel();

    final currentQuestion = _questions[_currentQuestionIndex];
    final correct = selectedIndex == currentQuestion.correctOptionIndex;

    setState(() {
      _isAnswered = true;
      _selectedOptionIndex = selectedIndex;
      _isCorrect = correct;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _showExplanation = true;
          if (correct) {
            _score += currentQuestion.points; // Simple scoring for now
          } else {
            _lives--;
          }
        });
      }
    });
  }

  void _handleNext() {
    if (_lives <= 0) {
      context.go('/survival/result', extra: _score);
      return;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showExplanation = false;
        _isAnswered = false;
        _selectedOptionIndex = null;
        _hiddenOptions = [];
        _isCorrect = null;
        _timer = TIMER_SECONDS;
      });
      _startTimer();
    } else {
      context.go('/survival/result', extra: _score);
    }
  }

  void _useHack() {
    if (!_hasHack || _isAnswered) return;
    final currentQuestion = _questions[_currentQuestionIndex];
    final wrongOptions = List.generate(4, (index) => index)
        .where((index) => index != currentQuestion.correctOptionIndex)
        .toList();
    wrongOptions.shuffle();
    setState(() {
      _hiddenOptions = wrongOptions.take(2).toList();
      _hasHack = false;
    });
  }

  void _useSkip() {
    if (!_hasSkip || _isAnswered) return;
    setState(() {
      _hasSkip = false;
    });
    // Skip logic: Reset timer, next question logic without penalty (unless implemented otherwise)
    // Using handleNext logic but without score update or lives update if not answered
    // Actually handleNext resets everything.

    // In React code: setTimeLeft(TIMER), setHiddenOptions([]), next quesiton logic
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showExplanation = false; // Just in case
        _isAnswered = false;
        _selectedOptionIndex = null;
        _hiddenOptions = [];
        _isCorrect = null;
        _timer = TIMER_SECONDS;
      });
      _startTimer();
    } else {
      context.go('/survival/result', extra: _score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showExplanation) {
      return _buildExplanationScreen();
    }
    return _buildGameScreen();
  }

  Widget _buildGameScreen() {
    final question = _questions[_currentQuestionIndex];

    // Timer Color Logic
    Color timerColor = AppTheme.primaryCyan;
    if (_timer <= 5)
      timerColor = AppTheme.destructive;
    else if (_timer <= 10) timerColor = Colors.yellow;

    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      body: SafeArea(
        child: Column(
          children: [
            // Timer Bar
            LinearProgressIndicator(
              value: _timer / TIMER_SECONDS,
              backgroundColor: AppTheme.zinc900,
              color: timerColor,
              minHeight: 4,
            ),

            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppTheme.zinc900.withOpacity(0.5),
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.white.withOpacity(0.05)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppTheme.primaryPurple.withOpacity(0.2),
                            border: Border.all(color: AppTheme.primaryPurple),
                            borderRadius: BorderRadius.circular(16)),
                        child: Text('AURA $_score',
                            style: GoogleFonts.orbitron(
                                color: AppTheme.primaryPurple,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Text(
                          'Rodada ${_currentQuestionIndex + 1}/${_questions.length}',
                          style:
                              TextStyle(color: AppTheme.zinc500, fontSize: 12))
                    ],
                  ),
                  Row(children: [
                    Icon(LucideIcons.timer, size: 16, color: timerColor),
                    const SizedBox(width: 4),
                    Text('${_timer}s',
                        style: TextStyle(
                            color: timerColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(width: 16),
                    Row(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Icon(
                                  LucideIcons.shield,
                                  size: 20,
                                  color: index < _lives
                                      ? AppTheme.primaryPink
                                      : AppTheme.zinc800,
                                ),
                              )),
                    )
                  ])
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Question
                    Text(
                      question.text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.4),
                    ),
                    const SizedBox(height: 48),

                    // Options
                    ...List.generate(question.options.length, (index) {
                      if (_hiddenOptions.contains(index)) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppTheme.zinc900.withOpacity(0.3),
                                border: Border.all(color: AppTheme.zinc800),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(question.options[index],
                                style: TextStyle(
                                    color: AppTheme.zinc700,
                                    decoration: TextDecoration.lineThrough)),
                          ),
                        );
                      }

                      final isSelected = _selectedOptionIndex == index;
                      final isCorrect = index == question.correctOptionIndex;
                      final showCorrect = _isAnswered && isCorrect;
                      final showWrong = _isAnswered && isSelected && !isCorrect;

                      Color borderColor = AppTheme.zinc700;
                      Color bgColor = AppTheme.zinc900;
                      Color textColor = AppTheme.zinc400;

                      if (showCorrect) {
                        borderColor = Colors.green;
                        bgColor = Colors.green.withOpacity(0.2);
                        textColor = Colors.green;
                      } else if (showWrong) {
                        borderColor = AppTheme.destructive;
                        bgColor = AppTheme.destructive.withOpacity(0.2);
                        textColor = AppTheme.destructive;
                      } else if (isSelected) {
                        borderColor = AppTheme.primaryCyan;
                        bgColor = AppTheme.primaryCyan.withOpacity(0.1);
                        textColor = AppTheme.primaryCyan;
                      } else if (!_isAnswered) {
                        // Default playable state
                        textColor = Colors.white;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _handleAnswer(index),
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: bgColor,
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: borderColor.withOpacity(0.5))),
                                  child: Center(
                                      child: Text(
                                          String.fromCharCode(65 + index),
                                          style: TextStyle(
                                              color: textColor,
                                              fontWeight: FontWeight.bold))),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                    child: Text(question.options[index],
                                        style: TextStyle(
                                            color: textColor.withOpacity(
                                                _isAnswered &&
                                                        !isSelected &&
                                                        !showCorrect
                                                    ? 0.5
                                                    : 1.0)))),
                                if (showCorrect)
                                  const Icon(LucideIcons.checkCircle,
                                      color: Colors.green, size: 20),
                                if (showWrong)
                                  const Icon(LucideIcons.xCircle,
                                      color: AppTheme.destructive, size: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Lifelines
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLifelineButton(
                      icon: LucideIcons.cpu,
                      label: 'HACKEAR',
                      subLabel: 'Tirar duas alternativas',
                      isActive: _hasHack,
                      onTap: _useHack,
                      color: AppTheme.primaryCyan),
                  const SizedBox(width: 24),
                  _buildLifelineButton(
                      icon: LucideIcons.fastForward,
                      label: 'PULAR',
                      subLabel: 'Pular pergunta',
                      isActive: _hasSkip,
                      onTap: _useSkip,
                      color: AppTheme.primaryPurple),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLifelineButton(
      {required IconData icon,
      required String label,
      required String subLabel,
      required bool isActive,
      required VoidCallback onTap,
      required Color color}) {
    return GestureDetector(
      onTap: isActive && !_isAnswered ? onTap : null,
      child: Opacity(
        opacity: isActive && !_isAnswered ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              color: isActive ? color.withOpacity(0.1) : AppTheme.zinc900,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isActive ? color.withOpacity(0.5) : AppTheme.zinc800)),
          child: Column(
            children: [
              Icon(icon, color: isActive ? color : AppTheme.zinc600),
              const SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                      color: isActive ? color : AppTheme.zinc600,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              Text(subLabel,
                  style: TextStyle(color: AppTheme.zinc600, fontSize: 8))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationScreen() {
    final question = _questions[_currentQuestionIndex];
    final isSuccess = _isCorrect == true;
    final color = isSuccess ? Colors.green : AppTheme.destructive;

    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      body: Column(
        children: [
          Container(height: 4, width: double.infinity, color: color),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: Icon(
                              isSuccess
                                  ? LucideIcons.checkCircle
                                  : (_selectedOptionIndex == null
                                      ? LucideIcons.clock
                                      : LucideIcons.alertTriangle),
                              color: color,
                              size: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                isSuccess
                                    ? 'SISTEMA SEGURO'
                                    : (_selectedOptionIndex == null
                                        ? 'TEMPO ESGOTADO'
                                        : 'FALHA DE SEGURANÇA'),
                                style: GoogleFonts.orbitron(
                                    color: color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                'Rodada ${_currentQuestionIndex + 1} • Aura $_score',
                                style: TextStyle(
                                    color: AppTheme.zinc500, fontSize: 12))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppTheme.zinc900,
                        border: Border.all(color: AppTheme.zinc800),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PERGUNTA',
                            style: TextStyle(
                                color: AppTheme.zinc500,
                                fontSize: 10,
                                letterSpacing: 1.5)),
                        const SizedBox(height: 8),
                        Text(question.text,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16, height: 1.5))
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...List.generate(question.options.length, (index) {
                    final isCorrectOption =
                        index == question.correctOptionIndex;
                    final wasSelected = index == _selectedOptionIndex;

                    Color itemBorder = AppTheme.zinc800;
                    Color itemBg = Colors.transparent;
                    Color itemText = AppTheme.zinc500;

                    if (isCorrectOption) {
                      itemBorder = Colors.green.withOpacity(0.5);
                      itemBg = Colors.green.withOpacity(0.05);
                      itemText = Colors.green;
                    } else if (wasSelected) {
                      itemBorder = AppTheme.destructive.withOpacity(0.5);
                      itemBg = AppTheme.destructive.withOpacity(0.05);
                      itemText = AppTheme.destructive;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: itemBg,
                            border: Border.all(color: itemBorder),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: itemText)),
                                  child: Center(
                                      child: Text(
                                          String.fromCharCode(65 + index),
                                          style: TextStyle(
                                              color: itemText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text(question.options[index],
                                        style: TextStyle(
                                            color: isCorrectOption
                                                ? Colors.green[300]
                                                : (wasSelected
                                                    ? Colors.red[300]
                                                    : AppTheme.zinc400),
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(question.explanations[index],
                                style: TextStyle(
                                    color: itemText.withOpacity(0.8),
                                    fontSize: 12,
                                    height: 1.4))
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),

          // Footer Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleNext,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryCyan,
                    foregroundColor: AppTheme.zinc950,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_lives <= 0 ? 'VER RESULTADO' : 'PRÓXIMA PERGUNTA',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    const Icon(LucideIcons.arrowRight, size: 20)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
