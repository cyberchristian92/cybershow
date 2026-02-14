import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cybershow/core/theme/app_theme.dart';
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
  // Mock Data
  final List<Question> _questions = [
    const Question(
      id: '1',
      text: 'Qual o principal objetivo de um ataque DDoS?',
      options: [
        'Roubar senhas',
        'Criptografar dados',
        'Indisponibilizar um serviço',
        'Interceptar Wi-Fi'
      ],
      correctOptionIndex: 2,
      points: 1000,
    ),
    const Question(
      id: '2',
      text: 'O que significa a sigla VPN?',
      options: [
        'Virtual Private Network',
        'Very Personal Network',
        'Virus Protection Node',
        'Verified Public Network'
      ],
      correctOptionIndex: 0,
      points: 2000,
    ),
    const Question(
      id: '3',
      text: 'Qual destas NÃO é uma boa prática de senha?',
      options: [
        'Usar caracteres especiais',
        'Usar data de nascimento',
        'Ter pelo menos 12 caracteres',
        'Usar gerenciador de senhas'
      ],
      correctOptionIndex: 1,
      points: 5000,
    ),
    const Question(
      id: '4',
      text: 'O que é Phishing?',
      options: [
        'Um tipo de peixe digital',
        'Técnica de enganar usuários para obter dados',
        'Um software antivírus',
        'Uma configuração de firewall'
      ],
      correctOptionIndex: 1,
      points: 10000,
    ),
    const Question(
      id: '5',
      text: 'Qual comando Linux lista os processos em execução?',
      options: ['ls', 'cd', 'ps', 'mkdir'],
      correctOptionIndex: 2,
      points: 50000,
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _lives = 3;
  int _timer = 30;
  Timer? _timerController;
  bool _isAnswered = false;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timerController?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = 30;
    _timerController = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timer > 0) {
        setState(() {
          _timer--;
        });
      } else {
        _handleTimeOut();
      }
    });
  }

  void _handleTimeOut() {
    _timerController?.cancel();
    _handleWrongAnswer();
  }

  void _handleAnswer(int selectedIndex) {
    if (_isAnswered) return;

    _timerController?.cancel();
    setState(() {
      _isAnswered = true;
      _selectedOptionIndex = selectedIndex;
    });

    final currentQuestion = _questions[_currentQuestionIndex];
    if (selectedIndex == currentQuestion.correctOptionIndex) {
      // Correct
      Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _score += currentQuestion.points;
            _isAnswered = false;
            _selectedOptionIndex = null;
          });
          _startTimer();
        } else {
          _showResultDialog(true);
        }
      });
    } else {
      // Incorrect
      Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
        _handleWrongAnswer();
      });
    }
  }

  void _handleWrongAnswer() {
    setState(() {
      _lives--;
    });

    if (_lives > 0) {
      // Reset for same question or next? Usually next in quizzes but Show do Milhao ends.
      // Let's implement strict mode: Wrong = Loss or just consume life?
      // Let's consume life and move next logic for "Arcade" feel or Restart?
      // Task says "Show do Milhao", which is elimination. But we have lives.
      // Let's consume life and NEXT question if possible, or restart question.
      // Simplified: Consume life, show correct answer, move next.

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _isAnswered = false;
          _selectedOptionIndex = null;
        });
        _startTimer();
      } else {
        _showResultDialog(true); // Finished but with fewer lives
      }
    } else {
      _showResultDialog(false);
    }
  }

  void _showResultDialog(bool success) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.zinc900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppTheme.zinc800),
        ),
        title: Text(
          success ? 'MISSÃO CUMPRIDA' : 'FALHA NA MISSÃO',
          style: GoogleFonts.orbitron(
            color: success ? AppTheme.primaryCyan : AppTheme.destructive,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              success ? LucideIcons.trophy : LucideIcons.skull,
              size: 64,
              color: success ? AppTheme.primaryCyan : AppTheme.destructive,
            ),
            const SizedBox(height: 16),
            Text(
              'Pontuação Final: $_score',
              style: GoogleFonts.orbitron(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/home'); // Back to dashboard
            },
            child: const Text('Voltar ao QG',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'RODADA ${_currentQuestionIndex + 1}/${_questions.length}',
          style: GoogleFonts.orbitron(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryCyan,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: List.generate(
                3,
                (index) => Icon(
                  LucideIcons.heart,
                  color:
                      index < _lives ? AppTheme.destructive : AppTheme.zinc800,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Timer Bar
            LinearProgressIndicator(
              value: _timer / 30,
              backgroundColor: AppTheme.zinc800,
              color: _timer < 10 ? AppTheme.destructive : AppTheme.primaryCyan,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 32),

            // Question Box
            FadeInDown(
              key: ValueKey(question.id),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.zinc900,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppTheme.primaryPurple.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryPurple.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Text(
                  question.text,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Options
            Expanded(
              child: ListView.separated(
                itemCount: question.options.length,
                separatorBuilder: (c, i) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final isSelected = _selectedOptionIndex == index;
                  final isCorrect = index == question.correctOptionIndex;
                  final showCorrect = _isAnswered && isCorrect;
                  final showWrong = _isAnswered && isSelected && !isCorrect;

                  Color borderColor = AppTheme.zinc800;
                  Color bgColor = Colors.transparent;

                  if (showCorrect) {
                    borderColor = Colors.green;
                    bgColor = Colors.green.withOpacity(0.2);
                  } else if (showWrong) {
                    borderColor = AppTheme.destructive;
                    bgColor = AppTheme.destructive.withOpacity(0.2);
                  } else if (isSelected) {
                    borderColor = AppTheme.primaryCyan;
                  }

                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: InkWell(
                      onTap: () => _handleAnswer(index),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: [
                            Text(
                              String.fromCharCode(65 + index), // A, B, C, D
                              style: GoogleFonts.orbitron(
                                color: showCorrect || showWrong
                                    ? Colors.white
                                    : AppTheme.primaryCyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (showCorrect)
                              const Icon(LucideIcons.checkCircle,
                                  color: Colors.green),
                            if (showWrong)
                              const Icon(LucideIcons.xCircle,
                                  color: AppTheme.destructive),
                          ],
                        ),
                      ),
                    ),
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
