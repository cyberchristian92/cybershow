import 'package:cybershow/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:cybershow/features/auth/presentation/screens/splash_screen.dart';
import 'package:cybershow/features/auth/presentation/screens/login_screen.dart';
import 'package:cybershow/features/home/presentation/screens/home_screen.dart';
import 'package:cybershow/features/career/presentation/screens/survival_lobby_screen.dart';

import 'package:cybershow/features/career/presentation/screens/survival_result_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/survival/result',
      builder: (context, state) {
        final score = state.extra as int? ?? 0;
        return SurvivalResultScreen(
          score: score,
          onRestart: () => context.go('/quiz'),
          onHome: () => context.go('/home'),
        );
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/survival',
      builder: (context, state) => const SurvivalLobbyScreen(),
    ),
  ],
);
