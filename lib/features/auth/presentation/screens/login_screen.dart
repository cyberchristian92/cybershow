import 'package:flutter/material.dart';
import 'package:cybershow/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Ensure this is available
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  bool _showPassword = false;

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _handleSubmit() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // Navigate to Onboarding on success
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const cyberCyan = AppTheme.primaryCyan;
    const cyberPurple = AppTheme.primaryPurple;
    const cyberPink = AppTheme.primaryPink;

    return Scaffold(
      backgroundColor: AppTheme.zinc950,
      body: Stack(
        children: [
          // Background Elements (Blobs)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cyberPurple.withOpacity(0.2),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .blur(begin: const Offset(10, 10), end: const Offset(50, 50)),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cyberCyan.withOpacity(0.2),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .blur(begin: const Offset(10, 10), end: const Offset(50, 50)),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.contain), // Assuming asset
                    ),
                    child: const Icon(LucideIcons.shield,
                        size: 60, color: cyberCyan), // Fallback
                  )
                      .animate()
                      .scale(duration: 600.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 24),

                  Text(
                    _isLogin ? 'Bem-vindo de volta' : 'Crie sua conta',
                    style: GoogleFonts.orbitron(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    _isLogin
                        ? 'Acesse sua conta para continuar'
                        : 'Junte-se à revolução da cibersegurança',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 32),

                  // Form Container
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF18181B)
                          .withOpacity(0.8), // cyber-input/50 backdrop
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // Top Gradient Line
                        Container(
                          height: 4,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [cyberCyan, cyberPurple, cyberPink],
                            ),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Form Fields
                        if (!_isLogin)
                          _CyberTextField(
                            label: 'NOME COMPLETO',
                            icon: LucideIcons.user,
                            controller: _nameController,
                          )
                              .animate()
                              .scaleY(
                                  alignment: Alignment.topCenter,
                                  begin: 0,
                                  end: 1,
                                  duration: 300.ms)
                              .fadeIn(),

                        if (!_isLogin) const SizedBox(height: 16),

                        _CyberTextField(
                          label: 'EMAIL',
                          icon: LucideIcons.mail,
                          controller: _emailController,
                        ),

                        const SizedBox(height: 16),

                        _CyberTextField(
                          label: 'SENHA',
                          icon: LucideIcons.lock,
                          controller: _passwordController,
                          isPassword: true,
                          showPassword: _showPassword,
                          onTogglePassword: () =>
                              setState(() => _showPassword = !_showPassword),
                        ),

                        if (!_isLogin) ...[
                          const SizedBox(height: 16),
                          _CyberTextField(
                            label: 'CONFIRMAR SENHA',
                            icon: LucideIcons.lock,
                            controller: _confirmPasswordController,
                            isPassword: true,
                          )
                              .animate()
                              .scaleY(
                                  alignment: Alignment.topCenter,
                                  begin: 0,
                                  end: 1,
                                  duration: 300.ms)
                              .fadeIn(),
                        ],

                        const SizedBox(height: 24),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.transparent, // Use Container gradient
                              padding: EdgeInsets.zero,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [cyberCyan, cyberPurple]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cyberCyan.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 1,
                                    )
                                  ]),
                              child: Center(
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2))
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _isLogin ? 'ENTRAR' : 'CADASTRAR',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(LucideIcons.arrowRight,
                                              color: Colors.white, size: 20),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_isLogin)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(color: cyberCyan),
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin ? 'Primeiro Acesso? ' : 'Já tem uma conta? ',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      TextButton(
                        onPressed: _toggleMode,
                        child: Text(
                          _isLogin ? 'Cadastre-se' : 'Entrar',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: cyberCyan),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CyberTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final bool showPassword;
  final VoidCallback? onTogglePassword;

  const _CyberTextField({
    required this.label,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.showPassword = false,
    this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF09090B), // cyber-dark
            border: Border.all(color: Colors.grey[700]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !showPassword,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: Colors.grey[500], size: 20),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                          showPassword ? LucideIcons.eyeOff : LucideIcons.eye,
                          color: Colors.grey[500],
                          size: 20),
                      onPressed: onTogglePassword,
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
