import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'login_page.dart';
import 'pages/dashboard/dashboard_page.dart';
import 'pages/upload_edital/upload_edital_page.dart';
import 'pages/configure_schedule/configure_schedule_page.dart';
import 'pages/study_plan/study_plan_page.dart';
import 'pages/revisao_flashcards/revisao_flashcards_page.dart';
import 'pages/pomodoro/pomodoro_page.dart';
import 'pages/review_progress/review_progress_page.dart';
import 'pages/account/account_page.dart';
import 'widgets/dashboard_layout.dart';

// Placeholders para as páginas internas do dashboard
class FlashcardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DashboardScaffold(
    title: 'Revisão e Flashcards',
    selectedIndex: 4,
    onMenuTap: (index) {
      Navigator.of(context).pushNamed(_routeForIndex(index));
    },
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.style, size: 64, color: Colors.purple[600]),
          const SizedBox(height: 16),
          Text(
            'Revisão e Flashcards',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flashcards gerados automaticamente para revisão',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  );

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanEstudeAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const LandingPage(),
      routes: {
        '/login': (context) => const LoginPage(initialTab: 0),
        '/signup': (context) => const LoginPage(initialTab: 1),
        '/dashboard': (context) => DashboardPage(
          isLoadingEditais: false,
          editais: const [],
          userName: 'Usuário',
        ),
        '/configure-schedule': (context) => ConfigureSchedulePage(),
        '/study-plan': (context) => const StudyPlanPage(),
        '/review-flashcards': (context) => FlashcardsPage(),
        '/pomodoro': (context) => PomodoroPage(),
        '/upload-edital': (context) => const UploadEditalPage(),
        '/revisao-flashcards': (context) => const RevisaoFlashcardsPage(),
        '/progresso': (context) => const ReviewProgressPage(),
        '/minha-conta': (context) => const AccountPage(),
      },
    );
  }
} 