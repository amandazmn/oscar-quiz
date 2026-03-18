import 'package:flutter/material.dart';

void main() {
  runApp(const OscarQuizApp());
}

class OscarQuizApp extends StatelessWidget {
  const OscarQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oscar Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB87A1A)),
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}

class Pergunta {
  final String texto;
  final List<String> opcoes;
  final int respostaCorreta;

  const Pergunta({
    required this.texto,
    required this.opcoes,
    required this.respostaCorreta,
  });
}

const List<Pergunta> perguntas = [
  Pergunta(
    texto: 'Qual foi o primeiro filme brasileiro a vencer um Oscar?',
    opcoes: [
      'Cidade de Deus',
      'Central do Brasil',
      'Ainda Estou Aqui',
      'O Pagador de Promessas',
    ],
    respostaCorreta: 2,
  ),
  Pergunta(
    texto: 'Qual filme ganhou o Oscar de Melhor Filme em 2024?',
    opcoes: ['Barbie', 'Oppenheimer', 'Poor Things', 'Maestro'],
    respostaCorreta: 1,
  ),
  Pergunta(
    texto: 'Quem ganhou o Oscar de Melhor Atriz em 2024?',
    opcoes: ['Carey Mulligan', 'Sandra Hüller', 'Emma Stone', 'Lily Gladstone'],
    respostaCorreta: 2,
  ),
  Pergunta(
    texto: 'Qual diretor ganhou o Oscar em 2024?',
    opcoes: [
      'Martin Scorsese',
      'Christopher Nolan',
      'Yorgos Lanthimos',
      'Bradley Cooper',
    ],
    respostaCorreta: 1,
  ),
  Pergunta(
    texto: 'Quantas estatuetas o Oppenheimer levou no Oscar 2024?',
    opcoes: ['5', '7', '9', '13'],
    respostaCorreta: 1,
  ),
  Pergunta(
    texto: 'Em qual categoria "Ainda Estou Aqui" venceu o Oscar 2025?',
    opcoes: [
      'Melhor Filme',
      'Melhor Atriz',
      'Melhor Filme Internacional',
      'Melhor Direção',
    ],
    respostaCorreta: 2,
  ),
  Pergunta(
    texto: 'Qual filme venceu o Oscar de Melhor Filme em 2025?',
    opcoes: ['O Brutalista', 'Anora', 'Emilia Pérez', 'Conclave'],
    respostaCorreta: 1,
  ),
  Pergunta(
    texto: 'Quem ganhou o Oscar de Melhor Atriz em 2025?',
    opcoes: [
      'Fernanda Torres',
      'Demi Moore',
      'Karla Sofía Gascón',
      'Mikey Madison',
    ],
    respostaCorreta: 3,
  ),
  Pergunta(
    texto: 'Qual filme venceu o Oscar de Melhor Filme em 2026?',
    opcoes: [
      'Pecadores',
      'Frankenstein',
      'Uma Batalha Após a Outra',
      'Hamnet',
    ],
    respostaCorreta: 2,
  ),
  Pergunta(
    texto: 'Quem venceu o Oscar de Melhor Ator em 2026?',
    opcoes: [
      'Paul Mescal',
      'Michael B. Jordan',
      'Adrien Brody',
      'Wagner Moura',
    ],
    respostaCorreta: 1,
  ),
  Pergunta(
    texto: 'Qual filme bateu o recorde de mais indicações na história do Oscar, em 2026?',
    opcoes: [
      'Uma Batalha Após a Outra',
      'Avatar: Fogo e Fúria',
      'Pecadores',
      'Frankenstein',
    ],
    respostaCorreta: 2,
  ),
  Pergunta(
    texto: 'Três filmes dividem o recorde de mais Oscars vencidos (11 estatuetas). Quais são?',
    opcoes: [
      'Titanic, Ben-Hur e O Senhor dos Anéis: O Retorno do Rei',
      'Casablanca, Titanic e La La Land',
      'Ben-Hur, Gladiador e Braveheart',
      'Titanic, Avatar e La La Land',
    ],
    respostaCorreta: 0,
  )
];

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _perguntaAtual = 0;
  int? _opcaoSelecionada;
  bool _respondeu = false;
  int _acertos = 0;

  // Cores
  static const Color ouro = Color(0xFFB87A1A);
  static const Color ouroClaro = Color(0xFFFEF6E4);
  static const Color ouroBorda = Color(0xFFD4A843);

  void _selecionarOpcao(int index) {
    if (_respondeu) return;
    setState(() {
      _opcaoSelecionada = index;
    });
  }

  void _confirmarResposta() {
    if (_opcaoSelecionada == null) return;

    setState(() {
      _respondeu = true;
      if (_opcaoSelecionada == perguntas[_perguntaAtual].respostaCorreta) {
        _acertos++;
      }
    });
  }

  void _proximaPergunta() {
    if (_perguntaAtual < perguntas.length - 1) {
      setState(() {
        _perguntaAtual++;
        _opcaoSelecionada = null;
        _respondeu = false;
      });
    } else {
      // Vai para a tela de resultado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultadoScreen(acertos: _acertos, total: perguntas.length),
        ),
      );
    }
  }

  Color _corOpcao(int index) {
    if (!_respondeu) {
      return _opcaoSelecionada == index ? ouroClaro : Colors.white;
    }
    if (index == perguntas[_perguntaAtual].respostaCorreta) {
      return Colors.green.shade50;
    }
    if (index == _opcaoSelecionada) {
      return Colors.red.shade50;
    }
    return Colors.white;
  }

  Color _corBorda(int index) {
    if (!_respondeu) {
      return _opcaoSelecionada == index ? ouroBorda : Colors.grey.shade300;
    }
    if (index == perguntas[_perguntaAtual].respostaCorreta) {
      return Colors.green;
    }
    if (index == _opcaoSelecionada) {
      return Colors.red;
    }
    return Colors.grey.shade300;
  }

  Color _corLetra(int index) {
    if (!_respondeu && _opcaoSelecionada == index) return ouro;
    if (_respondeu && index == perguntas[_perguntaAtual].respostaCorreta) {
      return Colors.green;
    }
    if (_respondeu && index == _opcaoSelecionada) return Colors.red;
    return Colors.grey.shade500;
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = perguntas[_perguntaAtual];
    final progresso = (_perguntaAtual + 1) / perguntas.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Oscar Quiz',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3D2B00),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progresso das perguntas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pergunta ${_perguntaAtual + 1} de ${perguntas.length}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '$_acertos acerto(s)',
                    style: const TextStyle(
                      fontSize: 13,
                      color: ouro,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progresso,
                  backgroundColor: Colors.grey.shade200,
                  color: ouro,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 24),

              // Pergunta
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  pergunta.texto,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Respostas
              Expanded(
                child: ListView.separated(
                  itemCount: pergunta.opcoes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final letra = String.fromCharCode(65 + index); // A, B, C, D
                    return GestureDetector(
                      onTap: () => _selecionarOpcao(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: _corOpcao(index),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _corBorda(index),
                            width: _opcaoSelecionada == index || _respondeu ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Bolinha com a letra
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: _corLetra(index)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                letra,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _corLetra(index),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                pergunta.opcoes[index],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ),
                            // Ícone de certo/errado
                            if (_respondeu)
                              Icon(
                                index == pergunta.respostaCorreta
                                    ? Icons.check_circle_outline
                                    : (index == _opcaoSelecionada
                                    ? Icons.cancel_outlined
                                    : null),
                                color: index == pergunta.respostaCorreta
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Botão principal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _respondeu
                      ? _proximaPergunta
                      : (_opcaoSelecionada != null ? _confirmarResposta : null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ouro,
                    disabledBackgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _respondeu
                        ? (_perguntaAtual < perguntas.length - 1
                        ? 'Próxima pergunta'
                        : 'Ver resultado')
                        : 'Confirmar resposta',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela de resultado

class ResultadoScreen extends StatelessWidget {
  final int acertos;
  final int total;

  const ResultadoScreen({super.key, required this.acertos, required this.total});

  String get _mensagem {
    final pct = acertos / total;
    if (pct == 1.0) return 'Perfeito! Você é um expert do Oscar! 🏆';
    if (pct >= 0.6) return 'Muito bem! Você conhece bastante! 🎬';
    return 'Continue assistindo filmes! 🍿';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 72)),
              const SizedBox(height: 24),
              const Text(
                'Fim do Quiz!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$acertos de $total acertos',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFB87A1A),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB87A1A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Jogar novamente',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}