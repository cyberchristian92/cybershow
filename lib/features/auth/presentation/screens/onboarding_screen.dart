import 'package:flutter/material.dart';
import 'package:cybershow/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentSlide = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'icon': LucideIcons.gamepad2,
      'title': 'Aprenda Jogando',
      'description':
          'Desafie seus conhecimentos em quizzes interativos e construa sua carreira em cibersegurança de forma divertida e envolvente.',
      'color': AppTheme.primaryCyan, // Cyber Cyan
    },
    {
      'icon': LucideIcons.users,
      'title': 'Conecte-se',
      'description':
          'Faça parte de uma comunidade engajada. Compartilhe conquistas, troque experiências e aprenda com outros profissionais da área.',
      'color': AppTheme.primaryPurple, // Cyber Purple
    },
    {
      'icon': LucideIcons.shield,
      'title': 'Segurança para Todos',
      'description':
          'Promovemos inclusão digital e acessibilidade. Acreditamos que a cibersegurança é um direito fundamental de todos.',
      'color': AppTheme.primaryPink, // Cyber Pink
    },
  ];

  void _nextSlide() {
    if (_currentSlide < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = _slides[_currentSlide]['color'] as Color;

    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: Stack(
        children: [
          // Background Lights
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [currentColor.withOpacity(0.2), Colors.transparent],
                    radius: 0.7,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Column(
            children: [
              // Top Bar
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Placeholder for Logo
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/logo.jpg'),
                              fit: BoxFit.contain), // Assuming we have this
                        ),
                        child: const Icon(LucideIcons.shield,
                            color: Colors.white, size: 24), // Fallback
                      ),
                      TextButton(
                        onPressed: () => context.go('/home'),
                        child: Text(
                          'Pular',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentSlide = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon Circle
                          Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF18181B),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.1)),
                              boxShadow: [
                                BoxShadow(
                                  color: (slide['color'] as Color)
                                      .withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: Icon(
                              slide['icon'] as IconData,
                              size: 64,
                              color: slide['color'] as Color,
                            ),
                          ).animate().scale(
                              duration: 500.ms, curve: Curves.easeOutBack),

                          const SizedBox(height: 32),

                          Text(
                            slide['title'] as String,
                            style: GoogleFonts.orbitron(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                              .animate()
                              .fadeIn(duration: 500.ms)
                              .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 16),

                          Text(
                            slide['description'] as String,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          )
                              .animate()
                              .fadeIn(delay: 200.ms)
                              .slideY(begin: 0.2, end: 0),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom Controls
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    // Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (index) {
                        final isActive = index == _currentSlide;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 32 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isActive
                                ? _slides[index]['color'] as Color
                                : Colors.grey[800],
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                        color:
                                            (_slides[index]['color'] as Color)
                                                .withOpacity(0.5),
                                        blurRadius: 8)
                                  ]
                                : [],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button (Hide on first slide)
                        Opacity(
                          opacity: _currentSlide > 0 ? 1 : 0,
                          child: IgnorePointer(
                            ignoring: _currentSlide == 0,
                            child: IconButton(
                              onPressed: () {
                                _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              },
                              icon: const Icon(LucideIcons.chevronLeft,
                                  color: Colors.grey),
                            ),
                          ),
                        ),

                        // Next Button
                        InkWell(
                          onTap: _nextSlide,
                          borderRadius: BorderRadius.circular(30),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            decoration: BoxDecoration(
                              gradient: _currentSlide == _slides.length - 1
                                  ? const LinearGradient(colors: [
                                      Color(0xFF00F0FF),
                                      Color(0xFFBD00FF)
                                    ])
                                  : null,
                              color: _currentSlide == _slides.length - 1
                                  ? null
                                  : const Color(0xFF18181B),
                              borderRadius: BorderRadius.circular(30),
                              border: _currentSlide == _slides.length - 1
                                  ? null
                                  : Border.all(color: Colors.grey[800]!),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _currentSlide == _slides.length - 1
                                      ? 'COMEÇAR'
                                      : '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                if (_currentSlide == _slides.length - 1)
                                  const SizedBox(width: 8),
                                Icon(
                                  LucideIcons.chevronRight,
                                  color: _currentSlide == _slides.length - 1
                                      ? Colors.white
                                      : Colors.grey[400],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
