import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import '../../widgets/dashboard_layout.dart';

class StudyPlanPage extends StatefulWidget {
  const StudyPlanPage({super.key});

  @override
  State<StudyPlanPage> createState() => _StudyPlanPageState();
}

class _StudyPlanPageState extends State<StudyPlanPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedDiscipline = "all";
  String selectedDay = "all";

  // Dados das disciplinas
  final List<Map<String, dynamic>> disciplines = [
    {"id": "port", "name": "Português", "color": Colors.blue},
    {"id": "math", "name": "Matemática", "color": Colors.green},
    {"id": "logic", "name": "Raciocínio Lógico", "color": Colors.orange},
    {"id": "info", "name": "Informática", "color": Colors.purple},
    {"id": "const", "name": "Direito Constitucional", "color": Colors.red},
    {"id": "admin", "name": "Direito Administrativo", "color": Colors.deepOrange},
    {"id": "legis", "name": "Legislação Específica", "color": Colors.indigo},
  ];

  final List<String> weekdays = [
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado",
    "Domingo"
  ];

  final List<String> timeSlots = [
    "08:00 - 10:00",
    "10:00 - 12:00",
    "14:00 - 16:00",
    "16:00 - 18:00",
    "19:00 - 21:00",
    "21:00 - 23:00"
  ];

  Map<String, List<Map<String, dynamic>>> studyPlan = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _generateMockPlan();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _generateMockPlan() {
    final random = Random();
    studyPlan.clear();

    for (String day in weekdays) {
      studyPlan[day] = [];

      // Pular domingo
      if (day == "Domingo") continue;

      // Gerar 2-3 sessões por dia
      int sessionsCount = random.nextInt(2) + 2;
      List<String> startTimes = ["08:00", "10:00", "14:00", "17:00", "19:00", "21:00"];
      List<Map<String, dynamic>> availableDisciplines = List.from(disciplines);

      for (int i = 0; i < sessionsCount; i++) {
        if (availableDisciplines.isEmpty) break;

        int disciplineIndex = random.nextInt(availableDisciplines.length);
        Map<String, dynamic> discipline = availableDisciplines.removeAt(disciplineIndex);

        int startTimeIndex = random.nextInt(startTimes.length);
        String startTime = startTimes.removeAt(startTimeIndex);

        int hours = int.parse(startTime.split(":")[0]);
        int endHours = hours + 2;
        String endTime = "${endHours.toString().padLeft(2, '0')}:00";

        studyPlan[day]!.add({
          "discipline": discipline,
          "topic": "Tópico ${i + 1} de ${discipline['name']}",
          "startTime": startTime,
          "endTime": endTime,
        });
      }

      // Ordenar por horário
      studyPlan[day]!.sort((a, b) => a["startTime"].compareTo(b["startTime"]));
    }
  }

  Map<String, List<Map<String, dynamic>>> get filteredStudyPlan {
    Map<String, List<Map<String, dynamic>>> filtered = {};

    studyPlan.forEach((day, sessions) {
      // Filtrar por dia
      if (selectedDay != "all" && day != selectedDay) return;

      List<Map<String, dynamic>> filteredSessions = sessions.where((session) {
        // Filtrar por disciplina
        return selectedDiscipline == "all" ||
            session["discipline"]["id"] == selectedDiscipline;
      }).toList();

      if (filteredSessions.isNotEmpty) {
        filtered[day] = filteredSessions;
      }
    });

    return filtered;
  }

  void _handleExportPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Exportando plano em PDF... (Funcionalidade simulada)")),
    );
  }

  void _handlePrint() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Funcionalidade de impressão simulada")),
    );
  }

  void _handleRefreshPlan() {
    setState(() {
      _generateMockPlan();
    });
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
      title: 'Plano de Estudo',
      selectedIndex: 3,
      onMenuTap: (index) {
        Navigator.of(context).pushNamed(_routeForIndex(index));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filtros
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Filtros",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedDiscipline,
                              decoration: const InputDecoration(
                                labelText: "Disciplina",
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: "all",
                                  child: Text("Todas as disciplinas"),
                                ),
                                ...disciplines.map((discipline) => DropdownMenuItem(
                                  value: discipline["id"],
                                  child: Text(discipline["name"]),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedDiscipline = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedDay,
                              decoration: const InputDecoration(
                                labelText: "Dia da Semana",
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: "all",
                                  child: Text("Todos os dias"),
                                ),
                                ...weekdays.map((day) => DropdownMenuItem(
                                  value: day,
                                  child: Text(day),
                                )),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedDay = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Tabs
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.blue,
                  tabs: const [
                    Tab(text: "Visão Semanal"),
                    Tab(text: "Visão Diária"),
                  ],
                ),
              ),
              SizedBox(
                height: 600,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildWeeklyView(),
                    _buildDailyView(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Legenda
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Legenda das disciplinas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 24,
                        runSpacing: 12,
                        children: disciplines.map((discipline) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: discipline["color"].withOpacity(0.15),
                                border: Border.all(color: discipline["color"]),
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              discipline["name"],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        )).toList(),
                      ),
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

  Widget _buildWeeklyView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: buildWeeklyGrid(),
        ),
      ),
    );
  }

  Widget buildWeeklyGrid() {
    if (filteredStudyPlan.isEmpty) {
      return Center(
        child: Text(
          "Nenhuma sessão encontrada com os filtros selecionados.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    // Determinar dias a exibir
    final List<String> daysToShow = selectedDay == "all" ? weekdays : [selectedDay];
    // Cabeçalho
    List<Widget> headerWidgets = [];
    headerWidgets.add(
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: const Text(
          "Horário",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ).withGridPlacement(columnStart: 0, rowStart: 0),
    );
    for (int col = 0; col < daysToShow.length; col++) {
      headerWidgets.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            daysToShow[col],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ).withGridPlacement(columnStart: col + 1, rowStart: 0),
      );
    }
    // Linhas de horários e células
    List<Widget> rowWidgets = [];
    for (int row = 0; row < timeSlots.length; row++) {
      rowWidgets.add(
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            timeSlots[row],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ).withGridPlacement(columnStart: 0, rowStart: row + 1),
      );
      for (int col = 0; col < daysToShow.length; col++) {
        final day = daysToShow[col];
        final parts = timeSlots[row].split(" - ");
        final startTime = parts[0];
        final endTime = parts[1];
        final sessions = filteredStudyPlan[day] ?? [];
        final session = sessions.firstWhere(
          (s) => s["startTime"] == startTime && s["endTime"] == endTime,
          orElse: () => {},
        );
        if (session.isNotEmpty && session["discipline"] != null) {
          final disc = session["discipline"];
          rowWidgets.add(
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: disc["color"]),
              ),
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: disc["color"].withOpacity(0.15),
                  border: Border.all(color: disc["color"]),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Text(
                      disc["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      session["topic"],
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ).withGridPlacement(columnStart: col + 1, rowStart: row + 1),
          );
        } else {
          rowWidgets.add(
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: const EdgeInsets.all(8),
              child: const SizedBox.shrink(),
            ).withGridPlacement(columnStart: col + 1, rowStart: row + 1),
          );
        }
      }
    }
    return LayoutGrid(
      columnSizes: [1.fr] + List.filled(daysToShow.length, 1.fr),
      rowSizes: [auto] + List.filled(timeSlots.length, auto),
      columnGap: 0,
      rowGap: 0,
      children: [
        ...headerWidgets,
        ...rowWidgets,
      ],
    );
  }

  Widget _buildDailyView() {
    if (filteredStudyPlan.isEmpty) {
      return const Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              "Nenhuma sessão encontrada com os filtros selecionados.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredStudyPlan.length,
      itemBuilder: (context, index) {
        final day = filteredStudyPlan.keys.elementAt(index);
        final sessions = filteredStudyPlan[day]!;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  day,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sessions.length,
                itemBuilder: (context, sessionIndex) {
                  final session = sessions[sessionIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: session["discipline"]["color"].withOpacity(0.1),
                        border: Border.all(color: session["discipline"]["color"]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session["discipline"]["name"],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  session["topic"],
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${session["startTime"]} - ${session["endTime"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 