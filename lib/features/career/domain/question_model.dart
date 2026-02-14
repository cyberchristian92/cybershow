class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation; // For the educational card
  final int difficulty; // 1 to 5

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    required this.difficulty,
  });

  // Mock Data for MVP
  static List<Question> get mockQuestions => [
        const Question(
          id: '1',
          text: 'Qual a senha mais segura?',
          options: ['123456', 'password', 'G@t0#2024!', 'admin'],
          correctOptionIndex: 2,
          explanation:
              'Senhas fortes devem conter letras maiúsculas, minúsculas, números e símbolos.',
          difficulty: 1,
        ),
        const Question(
          id: '2',
          text: 'O que é Phishing?',
          options: [
            'Um esporte aquático',
            'Um tipo de vírus',
            'Uma tentativa de golpe por e-mail',
            'Um firewall'
          ],
          correctOptionIndex: 2,
          explanation:
              'Phishing é uma técnica de engenharia social usada para enganar usuários e obter dados confidenciais.',
          difficulty: 1,
        ),
        const Question(
          id: '3',
          text: 'Qual o principal objetivo de um Firewall?',
          options: [
            'Acelerar a internet',
            'Filtrar tráfego de rede',
            'Limpar vírus',
            'Imprimir documentos'
          ],
          correctOptionIndex: 1,
          explanation:
              'O Firewall monitora e controla o tráfego de rede, permitindo ou bloqueando dados com base em regras de segurança.',
          difficulty: 2,
        ),
      ];
}
