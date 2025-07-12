import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

class ConfigureSchedulePage extends StatefulWidget {
  const ConfigureSchedulePage({super.key});

  @override
  State<ConfigureSchedulePage> createState() => _ConfigureSchedulePageState();
}

class _ConfigureSchedulePageState extends State<ConfigureSchedulePage> {
  bool loading = false;
  String hoursPerDay = '2';
  Map<String, bool> selectedDays = {
    'monday': true,
    'tuesday': true,
    'wednesday': true,
    'thursday': true,
    'friday': true,
    'saturday': true,
    'sunday': false,
  };

  final List<Map<String, dynamic>> disciplines = [
    { 'id': 1, 'name': 'Português', 'weight': 20, 'priority': 'medium' },
    { 'id': 2, 'name': 'Matemática', 'weight': 15, 'priority': 'high' },
    { 'id': 3, 'name': 'Raciocínio Lógico', 'weight': 15, 'priority': 'low' },
    { 'id': 4, 'name': 'Informática', 'weight': 10, 'priority': 'low' },
    { 'id': 5, 'name': 'Direito Constitucional', 'weight': 15, 'priority': 'high' },
    { 'id': 6, 'name': 'Direito Administrativo', 'weight': 15, 'priority': 'medium' },
    { 'id': 7, 'name': 'Legislação Específica', 'weight': 10, 'priority': 'medium' },
  ];

  late Map<int, String> disciplinePriorities;

  @override
  void initState() {
    super.initState();
    disciplinePriorities = {
      for (var d in disciplines) d['id'] as int: d['priority'] as String
    };
  }

  void handleDayToggle(String day) {
    setState(() {
      selectedDays[day] = !(selectedDays[day] ?? false);
    });
  }

  void handlePriorityChange(int disciplineId, String priority) {
    setState(() {
      disciplinePriorities[disciplineId] = priority;
    });
  }

  Future<void> handleGeneratePlan() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => loading = false);
    // Aqui você pode navegar para a tela de plano de estudo
    // Navigator.pushNamed(context, '/study-plan');
  }

  @override
  Widget build(BuildContext context) {
    final dayLabels = [
      {'id': 'monday', 'label': 'Segunda'},
      {'id': 'tuesday', 'label': 'Terça'},
      {'id': 'wednesday', 'label': 'Quarta'},
      {'id': 'thursday', 'label': 'Quinta'},
      {'id': 'friday', 'label': 'Sexta'},
      {'id': 'saturday', 'label': 'Sábado'},
      {'id': 'sunday', 'label': 'Domingo'},
    ];

    return DashboardScaffold(
      title: 'Configurar Agenda',
      selectedIndex: 2,
      onMenuTap: (index) {
        Navigator.of(context).pushNamed(_routeForIndex(index));
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configurar Agenda de Estudo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Color(0xFF222B45),
              ),
            ),
            const SizedBox(height: 28),
            // Card Disponibilidade de Tempo
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 28),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Disponibilidade de Tempo',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 18),
                    const Text('Quantas horas você pode estudar por dia?', style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: hoursPerDay,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: [
                        for (var i = 1; i <= 7; i++)
                          DropdownMenuItem(value: '$i', child: Text('$i ${i == 1 ? 'hora' : 'horas'}')),
                        const DropdownMenuItem(value: '8', child: Text('8 horas ou mais')),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => hoursPerDay = value);
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Quais dias da semana você pode estudar?', style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      children: [
                        for (var day in dayLabels)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: selectedDays[day['id']],
                                onChanged: (_) => handleDayToggle(day['id']!),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              ),
                              Text(day['label']!, style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Card Priorização de Disciplinas
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 32),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Priorização de Disciplinas',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Defina suas prioridades para cada disciplina. As disciplinas de alta prioridade terão mais tempo dedicado no seu plano de estudos.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                    ),
                    const SizedBox(height: 18),
                    Column(
                      children: [
                        for (var discipline in disciplines)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Text(discipline['name'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF3F4F6),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text('Peso: ${discipline['weight']}%', style: const TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    value: disciplinePriorities[discipline['id']],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    ),
                                    items: const [
                                      DropdownMenuItem(value: 'high', child: Text('Alta Prioridade')),
                                      DropdownMenuItem(value: 'medium', child: Text('Prioridade Média')),
                                      DropdownMenuItem(value: 'low', child: Text('Baixa Prioridade')),
                                    ],
                                    onChanged: (value) {
                                      if (value != null) handlePriorityChange(discipline['id'], value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Botão Gerar Plano
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: loading || selectedDays.values.where((v) => v).isEmpty ? null : handleGeneratePlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: loading
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Gerando Plano...'),
                          ],
                        )
                      : const Text('Gerar Plano de Estudos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
        return '/review-flashcards';
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
} 