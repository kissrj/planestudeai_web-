import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

class ReviewProgressPage extends StatefulWidget {
  const ReviewProgressPage({Key? key}) : super(key: key);

  @override
  State<ReviewProgressPage> createState() => _ReviewProgressPageState();
}

class _ReviewProgressPageState extends State<ReviewProgressPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTab = 0;

  // Mock data
  final List<Map<String, dynamic>> pendingReviews = [
    {
      'id': 1,
      'subject': 'Direito Constitucional',
      'topic': 'Direitos Fundamentais',
      'originalStudyDate': '10/05/2023',
      'reviewType': '24h',
      'dueDate': '11/05/2023',
      'status': 'urgent',
    },
    {
      'id': 2,
      'subject': 'Português',
      'topic': 'Análise Sintática',
      'originalStudyDate': '09/05/2023',
      'reviewType': '24h',
      'dueDate': '10/05/2023',
      'status': 'overdue',
    },
    {
      'id': 3,
      'subject': 'Raciocínio Lógico',
      'topic': 'Probabilidade',
      'originalStudyDate': '04/05/2023',
      'reviewType': '7d',
      'dueDate': '11/05/2023',
      'status': 'upcoming',
    },
  ];

  final List<Map<String, dynamic>> completedReviews = [
    {
      'id': 101,
      'subject': 'Direito Administrativo',
      'topic': 'Atos Administrativos',
      'originalStudyDate': '01/05/2023',
      'reviewType': '7d',
      'completedDate': '08/05/2023',
      'status': 'completed',
    },
    {
      'id': 102,
      'subject': 'Matemática',
      'topic': 'Juros Compostos',
      'originalStudyDate': '05/05/2023',
      'reviewType': '24h',
      'completedDate': '06/05/2023',
      'status': 'completed',
    },
    {
      'id': 103,
      'subject': 'Informática',
      'topic': 'Redes de Computadores',
      'originalStudyDate': '01/04/2023',
      'reviewType': '30d',
      'completedDate': '01/05/2023',
      'status': 'completed',
    },
  ];

  final List<Map<String, dynamic>> disciplineProgress = [
    {'name': 'Português', 'progress': 75, 'topics': 15, 'topicsCompleted': 12},
    {'name': 'Matemática', 'progress': 60, 'topics': 10, 'topicsCompleted': 6},
    {'name': 'Raciocínio Lógico', 'progress': 40, 'topics': 8, 'topicsCompleted': 3},
    {'name': 'Informática', 'progress': 85, 'topics': 12, 'topicsCompleted': 10},
    {'name': 'Direito Constitucional', 'progress': 30, 'topics': 20, 'topicsCompleted': 6},
    {'name': 'Direito Administrativo', 'progress': 50, 'topics': 18, 'topicsCompleted': 9},
    {'name': 'Legislação Específica', 'progress': 25, 'topics': 8, 'topicsCompleted': 2},
  ];

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

  Widget getStatusBadge(String status) {
    switch (status) {
      case 'urgent':
        return _badge('Urgente', Colors.red);
      case 'overdue':
        return _badge('Atrasada', Colors.red.shade700);
      case 'upcoming':
        return _badge('Em breve', Colors.amber);
      case 'completed':
        return _badge('Concluída', Colors.green);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget getStatusIcon(String status) {
    switch (status) {
      case 'urgent':
        return const Icon(Icons.error, color: Colors.red, size: 22);
      case 'overdue':
        return const Icon(Icons.error, color: Colors.redAccent, size: 22);
      case 'upcoming':
        return const Icon(Icons.access_time, color: Colors.amber, size: 22);
      case 'completed':
        return const Icon(Icons.check_circle, color: Colors.green, size: 22);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _badge(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  void handleMarkComplete(int reviewId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Revisão $reviewId marcada como concluída!')),
    );
    // Aqui você pode atualizar o estado se desejar
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: 'Revisão e Progresso',
      selectedIndex: 6,
      onMenuTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/dashboard');
            break;
          case 1:
            Navigator.of(context).pushNamed('/upload-edital');
            break;
          case 2:
            Navigator.of(context).pushNamed('/configure-schedule');
            break;
          case 3:
            Navigator.of(context).pushNamed('/study-plan');
            break;
          case 4:
            Navigator.of(context).pushNamed('/revisao-flashcards');
            break;
          case 5:
            Navigator.of(context).pushNamed('/pomodoro');
            break;
          case 6:
            Navigator.of(context).pushNamed('/progresso');
            break;
          case 7:
            Navigator.of(context).pushNamed('/minha-conta');
            break;
          default:
            Navigator.of(context).pushNamed('/dashboard');
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card Técnica de Revisão Espaçada
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Técnica de Revisão Espaçada', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 12),
                      const Text(
                        'Nosso sistema utiliza o método científico de revisão espaçada para maximizar sua retenção de conteúdo.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      _reviewStep('1', 'Primeira revisão: 24 horas', 'Revise o conteúdo um dia após o estudo inicial'),
                      _reviewStep('2', 'Segunda revisão: 7 dias', 'Revise novamente após uma semana'),
                      _reviewStep('3', 'Terceira revisão: 30 dias', 'Faça uma revisão final após um mês'),
                    ],
                  ),
                ),
              ),
              // Card Progresso do Estudo
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Progresso do Estudo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Row(
                            children: [
                              _legendDot(Colors.red, 'Atrasada'),
                              const SizedBox(width: 12),
                              _legendDot(Colors.amber, 'Em breve'),
                              const SizedBox(width: 12),
                              _legendDot(Colors.green, 'Concluída'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Progresso Geral', style: TextStyle(fontSize: 14)),
                                const SizedBox(height: 4),
                                LinearProgressIndicator(value: 0.52, minHeight: 8, backgroundColor: Color(0xFFE5E7EB), color: Colors.blue),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('52%', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 32,
                        runSpacing: 12,
                        children: disciplineProgress.take(4).map((discipline) {
                          return SizedBox(
                            width: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(discipline['name'], style: const TextStyle(fontSize: 13)),
                                    Text('${discipline['progress']}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: (discipline['progress'] as int) / 100,
                                        minHeight: 6,
                                        backgroundColor: const Color(0xFFE5E7EB),
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('${discipline['topicsCompleted']}/${discipline['topics']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              // Card Suas Revisões
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Suas Revisões', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 400),
                              child: TabBar(
                                controller: _tabController,
                                labelColor: Colors.blue,
                                unselectedLabelColor: Colors.black54,
                                indicatorColor: Colors.blue,
                                tabs: const [
                                  Tab(text: 'Pendentes'),
                                  Tab(text: 'Concluídas'),
                                ],
                                onTap: (index) => setState(() => activeTab = index),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 220,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Pendentes
                            pendingReviews.isEmpty
                                ? const Center(child: Text('Nenhuma revisão pendente.', style: TextStyle(color: Colors.grey)))
                                : ListView.separated(
                                    itemCount: pendingReviews.length,
                                    separatorBuilder: (_, __) => const Divider(),
                                    itemBuilder: (context, i) {
                                      final review = pendingReviews[i];
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          getStatusIcon(review['status']),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(review['subject'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                                    getStatusBadge(review['status']),
                                                    _badge('Revisão ${review['reviewType']}', Colors.blue),
                                                  ],
                                                ),
                                                Text(review['topic'], style: const TextStyle(color: Colors.grey)),
                                                Text('Estudado em: ${review['originalStudyDate']} | Revisão até: ${review['dueDate']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: () => handleMarkComplete(review['id']),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            ),
                                            child: const Text('Marcar como revisado', style: TextStyle(fontSize: 13)),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                            // Concluídas
                            completedReviews.isEmpty
                                ? const Center(child: Text('Nenhuma revisão concluída.', style: TextStyle(color: Colors.grey)))
                                : ListView.separated(
                                    itemCount: completedReviews.length,
                                    separatorBuilder: (_, __) => const Divider(),
                                    itemBuilder: (context, i) {
                                      final review = completedReviews[i];
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.check_circle, color: Colors.green, size: 22),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(review['subject'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                                    _badge('Concluída', Colors.green),
                                                    _badge('Revisão ${review['reviewType']}', Colors.blue),
                                                  ],
                                                ),
                                                Text(review['topic'], style: const TextStyle(color: Colors.grey)),
                                                Text('Estudado em: ${review['originalStudyDate']} | Revisado em: ${review['completedDate']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          OutlinedButton(
                                            onPressed: null,
                                            style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            ),
                                            child: const Text('Concluído', style: TextStyle(fontSize: 13)),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Card Progresso por Disciplina
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Progresso por Disciplina', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 18),
                      ...disciplineProgress.map((discipline) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(discipline['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('${discipline['progress']}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (discipline['progress'] as int) / 100,
                                    minHeight: 8,
                                    backgroundColor: const Color(0xFFE5E7EB),
                                    color: Colors.blue[900],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text('${discipline['topicsCompleted']}/${discipline['topics']} tópicos', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _reviewStep(String number, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(number, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 