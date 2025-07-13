import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

class Revisao {
  final String disciplina;
  final String tag;
  final String ciclo;
  final DateTime estudadoEm;
  final DateTime revisarEm;
  String status; // 'atrasada', 'pendente', 'concluida'

  Revisao({
    required this.disciplina,
    required this.tag,
    required this.ciclo,
    required this.estudadoEm,
    required this.revisarEm,
    required this.status,
  });
}

class RevisaoFlashcardsPage extends StatefulWidget {
  const RevisaoFlashcardsPage({Key? key}) : super(key: key);

  @override
  State<RevisaoFlashcardsPage> createState() => _RevisaoFlashcardsPageState();
}

class _RevisaoFlashcardsPageState extends State<RevisaoFlashcardsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _routeForIndex(int index) {
    switch (index) {
      case 0:
        return '/dashboard';
      case 1:
        return '/upload-edital';
      case 2:
        return '/configure-schedule';
      case 3:
        return '/study-plan';
      case 4:
        return '/revisao-flashcards';
      case 5:
        return '/pomodoro';
      case 6:
        return '/progresso';
      case 7:
        return '/minha-conta';
      default:
        return '/dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: 'Revisão e Flashcards',
      selectedIndex: 4,
      onMenuTap: (index) {
        Navigator.of(context).pushNamed(_routeForIndex(index));
      },
      child: Container(
        color: const Color(0xFFF8F9FB),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              children: [
                Icon(Icons.menu_book, color: Colors.blue[800], size: 36),
                const Text(
                  "Revisão e Flashcards",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Organize suas revisões e maximize sua memorização com flashcards inteligentes",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            const SizedBox(height: 24),
            // Tabs
            Container(
              width: double.infinity,
              constraints: BoxConstraints(maxWidth: 700),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.blue[800],
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.blue[800],
                tabs: const [
                  Tab(text: "Revisão por Ciclos"),
                  Tab(text: "Flashcards Inteligentes"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 900),
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    RevisionCyclesWidget(),
                    FlashcardsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RevisionCyclesWidget extends StatefulWidget {
  const RevisionCyclesWidget({Key? key}) : super(key: key);

  @override
  State<RevisionCyclesWidget> createState() => _RevisionCyclesWidgetState();
}

class _RevisionCyclesWidgetState extends State<RevisionCyclesWidget> {
  List<Revisao> revisoes = [
    Revisao(
      disciplina: "Português",
      tag: "Figuras de Linguagem",
      ciclo: "24h",
      estudadoEm: DateTime(2025, 5, 12),
      revisarEm: DateTime(2025, 5, 13),
      status: "atrasada",
    ),
    Revisao(
      disciplina: "Direito Constitucional",
      tag: "Direitos Fundamentais",
      ciclo: "7d",
      estudadoEm: DateTime(2025, 5, 10),
      revisarEm: DateTime(2025, 5, 15),
      status: "pendente",
    ),
    Revisao(
      disciplina: "Direito Administrativo",
      tag: "Licitações",
      ciclo: "30d",
      estudadoEm: DateTime(2025, 5, 1),
      revisarEm: DateTime(2025, 6, 1),
      status: "pendente",
    ),
    Revisao(
      disciplina: "Matemática",
      tag: "Regra de Três",
      ciclo: "7d",
      estudadoEm: DateTime(2025, 5, 5),
      revisarEm: DateTime(2025, 5, 16),
      status: "concluida",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    int concluidas = revisoes.where((r) => r.status == 'concluida').length;
    int atrasadas = revisoes.where((r) => r.status == 'atrasada').length;
    int pendentes = revisoes.where((r) => r.status == 'pendente').length;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cards de progresso
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 240, maxWidth: 360),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0.5,
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 10 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Progresso de revisões", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("$concluidas/${revisoes.length}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const Text("Revisões concluídas", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: revisoes.isEmpty ? 0 : concluidas / revisoes.length,
                          backgroundColor: Colors.grey[200],
                          color: Colors.blue[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 240, maxWidth: 360),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0.5,
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 10 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Próximas revisões", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("$pendentes", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const Text("Pendentes", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 240, maxWidth: 360),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0.5,
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 10 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Revisões atrasadas", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("$atrasadas", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const Text("Atrasadas", style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: const Text("Simular estudo concluído"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            "Agenda de Revisão",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          // Lista de cards de revisão
          Column(
            children: revisoes.map((r) => RevisaoCard(
              revisao: r,
              onMarcarRevisada: () {
                setState(() {
                  r.status = 'concluida';
                });
              },
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class RevisaoCard extends StatelessWidget {
  final Revisao revisao;
  final VoidCallback onMarcarRevisada;

  const RevisaoCard({Key? key, required this.revisao, required this.onMarcarRevisada}) : super(key: key);

  Color getBorderColor() {
    switch (revisao.status) {
      case 'atrasada':
        return Colors.red;
      case 'pendente':
        return Colors.amber;
      case 'concluida':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color? getStatusColor() {
    switch (revisao.status) {
      case 'atrasada':
        return Colors.red[700];
      case 'pendente':
        return Colors.amber[800];
      case 'concluida':
        return Colors.green[700];
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {
    switch (revisao.status) {
      case 'atrasada':
        return Icons.warning_amber_rounded;
      case 'pendente':
        return Icons.access_time_rounded;
      case 'concluida':
        return Icons.check_circle_outline;
      default:
        return Icons.info_outline;
    }
  }

  String getStatusText() {
    switch (revisao.status) {
      case 'atrasada':
        return 'Atrasada';
      case 'pendente':
        return 'Pendente';
      case 'concluida':
        return 'Concluída';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 240, maxWidth: 648),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: getBorderColor(), width: 2),
        ),
        elevation: 0.5,
        margin: const EdgeInsets.only(bottom: 18),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      revisao.disciplina,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: getBorderColor()),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      revisao.tag,
                      style: const TextStyle(fontSize: 13, color: Colors.blue),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Ciclo: ${revisao.ciclo}',
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(getStatusIcon(), color: getStatusColor()),
                  const SizedBox(width: 4),
                  Text(
                    getStatusText(),
                    style: TextStyle(
                      color: getStatusColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'Estudado em: ${_formatDate(revisao.estudadoEm)}',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              Text(
                'Revisar em: ${_formatDate(revisao.revisarEm)}',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              if (revisao.status != 'concluida')
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton.icon(
                      onPressed: onMarcarRevisada,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      ),
                      icon: const Icon(Icons.check),
                      label: const Text("Marcar como revisada"),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} de ${_mesExtenso(date.month)} de ${date.year}';
  }

  String _mesExtenso(int mes) {
    const meses = [
      '', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
      'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
    ];
    return meses[mes];
  }
}

class Flashcard {
  final String pergunta;
  final String resposta;
  final String disciplina;
  Flashcard({required this.pergunta, required this.resposta, required this.disciplina});
}

class FlashcardsWidget extends StatefulWidget {
  const FlashcardsWidget({Key? key}) : super(key: key);

  @override
  State<FlashcardsWidget> createState() => _FlashcardsWidgetState();
}

class _FlashcardsWidgetState extends State<FlashcardsWidget> {
  final List<Flashcard> flashcards = [
    Flashcard(
      pergunta: 'O que é uma metáfora?',
      resposta: 'É uma figura de linguagem que estabelece uma relação de semelhança entre dois termos.',
      disciplina: 'Português',
    ),
    Flashcard(
      pergunta: 'O que são direitos fundamentais?',
      resposta: 'São direitos básicos assegurados pela Constituição a todos os cidadãos.',
      disciplina: 'Direito Constitucional',
    ),
    Flashcard(
      pergunta: 'O que é uma licitação?',
      resposta: 'É o procedimento administrativo para contratação de serviços ou aquisição de produtos pelo poder público.',
      disciplina: 'Direito Administrativo',
    ),
    Flashcard(
      pergunta: 'Como resolver uma regra de três simples?',
      resposta: 'Multiplica-se em cruz e resolve-se a equação resultante.',
      disciplina: 'Matemática',
    ),
  ];

  int currentIndex = 0;
  bool mostrarResposta = false;
  List<bool?> resultados = [];

  @override
  void initState() {
    super.initState();
    resultados = List<bool?>.filled(flashcards.length, null);
  }

  void _marcar(bool certo) {
    setState(() {
      resultados[currentIndex] = certo;
      mostrarResposta = false;
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
      }
    });
  }

  void _mostrarResposta() {
    setState(() {
      mostrarResposta = true;
    });
  }

  void _anterior() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        mostrarResposta = false;
      }
    });
  }

  void _proximo() {
    setState(() {
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
        mostrarResposta = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = flashcards[currentIndex];
    final resultado = resultados[currentIndex];
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 240, maxWidth: 360),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 16 : 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  card.disciplina,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                ),
                const SizedBox(height: 16),
                Text(
                  card.pergunta,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (mostrarResposta)
                  Column(
                    children: [
                      Text(
                        card.resposta,
                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _marcar(true),
                            icon: const Icon(Icons.check, color: Colors.white),
                            label: const Text('Acertei'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _marcar(false),
                            icon: const Icon(Icons.close, color: Colors.white),
                            label: const Text('Errei'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  ElevatedButton(
                    onPressed: _mostrarResposta,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: const Text('Mostrar resposta'),
                  ),
                if (resultado != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(
                          resultado ? Icons.check_circle : Icons.cancel,
                          color: resultado ? Colors.green : Colors.red,
                        ),
                        Text(
                          resultado ? 'Você acertou!' : 'Você errou',
                          style: TextStyle(
                            color: resultado ? Colors.green[700] : Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 