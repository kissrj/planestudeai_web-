import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../widgets/dashboard_layout.dart';

class Task {
  final String id;
  final String subject;
  final String topic;
  final String duration;
  Task({required this.id, required this.subject, required this.topic, required this.duration});
}

enum TimerType { focus, shortBreak, longBreak }

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  // Timer settings
  Map<TimerType, int> timerSettings = {
    TimerType.focus: 25 * 60,
    TimerType.shortBreak: 5 * 60,
    TimerType.longBreak: 15 * 60,
  };
  int longBreakInterval = 4;

  // Timer state
  TimerType timerType = TimerType.focus;
  int timeRemaining = 25 * 60;
  bool isActive = false;
  bool isPaused = false;
  int completedFocusSessions = 0;
  bool soundEnabled = true;
  String? selectedTask;

  // Estatísticas
  int pomodorosToday = 0;
  int minutesFocusedToday = 0;
  int minutesFocusedThisWeek = 0;

  // Mock de tarefas
  final List<Task> todaysTasks = [
    Task(id: "1", subject: "Direito Constitucional", topic: "Direitos Fundamentais", duration: "2h"),
    Task(id: "2", subject: "Português", topic: "Sintaxe", duration: "1h30min"),
    Task(id: "3", subject: "Raciocínio Lógico", topic: "Probabilidade", duration: "1h"),
  ];

  // Timer
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    timeRemaining = timerSettings[timerType]!;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (isActive && !isPaused) return;
    setState(() {
      isActive = true;
      isPaused = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isActive || isPaused) {
        timer.cancel();
        return;
      }
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        handleTimerEnd();
        timer.cancel();
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
    _timer?.cancel();
  }

  void resetTimer() {
    setState(() {
      timeRemaining = timerSettings[timerType]!;
      isActive = false;
      isPaused = false;
    });
    _timer?.cancel();
  }

  void changeTimerType(TimerType type) {
    setState(() {
      timerType = type;
      timeRemaining = timerSettings[type]!;
      isActive = false;
      isPaused = false;
    });
    _timer?.cancel();
  }

  void handleTimerEnd() {
    if (timerType == TimerType.focus) {
      setState(() {
        pomodorosToday++;
        minutesFocusedToday += (timerSettings[TimerType.focus]! ~/ 60);
        minutesFocusedThisWeek += (timerSettings[TimerType.focus]! ~/ 60);
        completedFocusSessions++;
      });
      // Próxima sessão
      if (completedFocusSessions % longBreakInterval == 0) {
        changeTimerType(TimerType.longBreak);
      } else {
        changeTimerType(TimerType.shortBreak);
      }
    } else {
      changeTimerType(TimerType.focus);
    }
    setState(() {
      isActive = false;
    });
  }

  String formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  double calculateProgress() {
    final totalTime = timerSettings[timerType]!;
    return (totalTime - timeRemaining) / totalTime;
  }

  void completeSession() {
    if (!isActive && !isPaused) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inicie uma sessão primeiro"), backgroundColor: Colors.red),
      );
      return;
    }
    if (selectedTask != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sessão concluída com sucesso!")),
      );
      resetTimer();
      setState(() {
        pomodorosToday++;
        minutesFocusedToday += ((timerSettings[timerType]! - timeRemaining) ~/ 60);
        minutesFocusedThisWeek += ((timerSettings[timerType]! - timeRemaining) ~/ 60);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione uma tarefa para registrar o progresso"), backgroundColor: Colors.red),
      );
    }
  }

  void updateTimerSetting(TimerType type, int minutes) {
    setState(() {
      timerSettings[type] = minutes * 60;
      if (timerType == type) {
        timeRemaining = minutes * 60;
      }
    });
  }

  // Mock de progresso semanal
  List<Map<String, dynamic>> get weeklyProgress => [
    {"day": "Seg", "minutes": 120},
    {"day": "Ter", "minutes": 90},
    {"day": "Qua", "minutes": 150},
    {"day": "Qui", "minutes": 75},
    {"day": "Sex", "minutes": minutesFocusedToday},
    {"day": "Sáb", "minutes": 0},
    {"day": "Dom", "minutes": 0},
  ];

  int get maxMinutes => weeklyProgress.map((d) => d["minutes"] as int).fold(60, max);

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: 'Gestor Pomodoro',
      selectedIndex: 5,
      onMenuTap: (index) {
        Navigator.of(context).pushNamed(_routeForIndex(index));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 24),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Temporizador Pomodoro", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() => soundEnabled = !soundEnabled),
                                icon: Icon(soundEnabled ? Icons.volume_up : Icons.volume_off, color: Colors.blue[800]),
                                tooltip: soundEnabled ? "Som ligado" : "Som desligado",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimerTypeButton(TimerType.focus, "Foco"),
                          const SizedBox(width: 8),
                          _buildTimerTypeButton(TimerType.shortBreak, "Pausa Curta"),
                          const SizedBox(width: 8),
                          _buildTimerTypeButton(TimerType.longBreak, "Pausa Longa"),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: CircularProgressIndicator(
                                value: calculateProgress(),
                                strokeWidth: 14,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(timerType == TimerType.focus ? Colors.blue[800]! : Colors.green[400]!),
                              ),
                            ),
                            Text(
                              formatTime(timeRemaining),
                              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isActive && !isPaused
                                ? ElevatedButton.icon(
                                    onPressed: pauseTimer,
                                    icon: const Icon(Icons.pause),
                                    label: const Text("Pausar"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[800],
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  )
                                : ElevatedButton.icon(
                                    onPressed: startTimer,
                                    icon: const Icon(Icons.play_arrow),
                                    label: Text(isPaused ? "Continuar" : "Iniciar"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[800],
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                            const SizedBox(width: 12),
                            OutlinedButton.icon(
                              onPressed: resetTimer,
                              icon: const Icon(Icons.refresh),
                              label: const Text("Reiniciar"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton.icon(
                              onPressed: completeSession,
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text("Concluir Sessão"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (timerType == TimerType.focus)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Center(
                            child: Text(
                              "Sessão ${completedFocusSessions % longBreakInterval + 1} de $longBreakInterval antes da pausa longa",
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 24),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tarefas para Hoje", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 16),
                      if (todaysTasks.isNotEmpty)
                        Column(
                          children: todaysTasks.map((task) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTask = task.id;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Tarefa selecionada: ${task.subject}")),
                              );
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 240, maxWidth: 648),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 8 : 16),
                                decoration: BoxDecoration(
                                  color: selectedTask == task.id ? Colors.blue[50] : Colors.white,
                                  border: Border.all(
                                    color: selectedTask == task.id ? Colors.blue : Colors.grey[300]!,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(task.subject, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text(task.topic, style: const TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(task.duration, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )).toList(),
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: Text("Nenhuma tarefa planejada para hoje", style: TextStyle(color: Colors.grey))),
                        ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text("Ver Plano de Estudo Completo"),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 24),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 240, maxWidth: 648),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.bar_chart, color: Colors.blue, size: 24),
                            SizedBox(width: 8),
                            Text("Estatísticas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildStatRow("Pomodoros hoje", pomodorosToday),
                        _buildStatRow("Minutos focados hoje", minutesFocusedToday),
                        _buildStatRow("Minutos na semana", minutesFocusedThisWeek),
                        const SizedBox(height: 24),
                        const Text("Progresso Semanal", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: weeklyProgress.map((day) {
                              final isToday = day["day"] == "Sex"; // Simulação
                              final percent = (day["minutes"] as int) / maxMinutes;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 400),
                                      height: 100 * percent,
                                      width: 18,
                                      decoration: BoxDecoration(
                                        color: isToday ? Colors.blue[800] : Colors.blue[200],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(day["day"], style: const TextStyle(fontSize: 11)),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "🔥 Você estudou 3 dias seguidos! Continue assim!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 24),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.settings, color: Colors.blue, size: 24),
                          SizedBox(width: 8),
                          Text("Configurações do Pomodoro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildConfigDropdown(
                        label: "Tempo de Foco (minutos)",
                        value: timerSettings[TimerType.focus]! ~/ 60,
                        options: const [15, 20, 25, 30, 35, 40, 45, 50, 55, 60],
                        onChanged: (v) => updateTimerSetting(TimerType.focus, v),
                      ),
                      _buildConfigDropdown(
                        label: "Pausa Curta (minutos)",
                        value: timerSettings[TimerType.shortBreak]! ~/ 60,
                        options: const [3, 5, 7, 10],
                        onChanged: (v) => updateTimerSetting(TimerType.shortBreak, v),
                      ),
                      _buildConfigDropdown(
                        label: "Pausa Longa (minutos)",
                        value: timerSettings[TimerType.longBreak]! ~/ 60,
                        options: const [10, 15, 20, 25, 30],
                        onChanged: (v) => updateTimerSetting(TimerType.longBreak, v),
                      ),
                      _buildConfigDropdown(
                        label: "Ciclos antes da pausa longa",
                        value: longBreakInterval,
                        options: const [2, 3, 4, 5, 6],
                        onChanged: (v) => setState(() => longBreakInterval = v),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (v) {},
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              "Modo de foco profundo (sem notificações)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
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

  Widget _buildTimerTypeButton(TimerType type, String label) {
    final bool selected = timerType == type;
    return ElevatedButton(
      onPressed: () => changeTimerType(type),
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.blue[800] : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.blue[800],
        elevation: 0,
        side: BorderSide(color: Colors.blue[800]!, width: selected ? 2 : 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      ),
      child: Text(label),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildConfigDropdown({
    required String label,
    required int value,
    required List<int> options,
    required ValueChanged<int> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 6),
          DropdownButton<int>(
            value: value,
            items: options.map((v) => DropdownMenuItem(value: v, child: Text("$v"))).toList(),
            onChanged: (v) => onChanged(v!),
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
} 