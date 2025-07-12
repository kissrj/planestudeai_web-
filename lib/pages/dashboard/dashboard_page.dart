import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';
import '../../widgets/dashboard_summary_card.dart';
import '../../widgets/dashboard_feature_card.dart';
import '../../widgets/dashboard_edital_list.dart';

class DashboardPage extends StatelessWidget {
  final bool isLoadingEditais;
  final List<Edital> editais;
  final String userName;

  const DashboardPage({
    super.key,
    required this.isLoadingEditais,
    required this.editais,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingEditais) {
      return DashboardScaffold(
        title: 'Dashboard',
        selectedIndex: 0,
        onMenuTap: (index) => _navigateDashboard(context, index),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Carregando...',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      );
    }

    final hasEdital = editais.isNotEmpty;

    if (!hasEdital) {
      return DashboardScaffold(
        title: 'Dashboard',
        selectedIndex: 0,
        onMenuTap: (index) => _navigateDashboard(context, index),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saudação personalizada
              Text(
                'Olá, $userName! 👋',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bem-vindo ao PlanEstudeAI. Vamos começar criando seu primeiro plano de estudos!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              // Card central
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Icon(Icons.description, color: Colors.blue[700], size: 48),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Nenhum edital encontrado',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Para começar a usar o PlanEstudeAI, você precisa colar o edital do seu concurso. Nossa IA analisará o conteúdo e criará um plano de estudos personalizado para você.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.upload),
                            label: const Text('Colar Edital'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.add_circle),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Criar Plano Manual'),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Em breve',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Cards de funcionalidades
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _FeatureCard(
                    icon: Icons.calendar_today,
                    title: 'Agenda de Estudos',
                    description: 'Configure sua rotina de estudos após adicionar um edital',
                    buttonText: 'Configurar Agenda',
                    onPressed: null,
                  ),
                  _FeatureCard(
                    icon: Icons.style,
                    title: 'Flashcards',
                    description: 'Revisão e flashcards serão gerados automaticamente',
                    buttonText: 'Ver Flashcards',
                    onPressed: null,
                  ),
                  _FeatureCard(
                    icon: Icons.timer,
                    title: 'Pomodoro',
                    description: 'Técnica de foco para otimizar seus estudos',
                    buttonText: 'Usar Pomodoro',
                    onPressed: null,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Estado com edital
    final latestEdital = editais.first;

    return DashboardScaffold(
      title: 'Dashboard',
      selectedIndex: 0,
      onMenuTap: (index) => _navigateDashboard(context, index),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saudação personalizada
            Text(
              'Olá, $userName! 👋',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bem-vindo ao PlanEstudeAI. Vamos começar criando seu primeiro plano de estudos!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            DashboardSummaryCard(
              edital: latestEdital,
              totalEditais: editais.length,
            ),
            const SizedBox(height: 32),
            // Cards de funcionalidades
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                _FeatureCard(
                  icon: Icons.calendar_today,
                  title: 'Agenda de Estudos',
                  description: 'Configure sua rotina de estudos após adicionar um edital',
                  buttonText: 'Configurar Agenda',
                  onPressed: () => Navigator.pushNamed(context, '/configure-schedule'),
                ),
                _FeatureCard(
                  icon: Icons.style,
                  title: 'Flashcards',
                  description: 'Revisão e flashcards serão gerados automaticamente',
                  buttonText: 'Ver Flashcards',
                  onPressed: () => Navigator.pushNamed(context, '/review-flashcards'),
                ),
                _FeatureCard(
                  icon: Icons.timer,
                  title: 'Pomodoro',
                  description: 'Técnica de foco para otimizar seus estudos',
                  buttonText: 'Usar Pomodoro',
                  onPressed: () => Navigator.pushNamed(context, '/pomodoro'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateDashboard(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/upload-edital');
        break;
      case 2:
        Navigator.pushNamed(context, '/configure-schedule');
        break;
      case 3:
        Navigator.pushNamed(context, '/study-plan');
        break;
      case 4:
        Navigator.pushNamed(context, '/review-flashcards');
        break;
      case 5:
        Navigator.pushNamed(context, '/pomodoro');
        break;
      case 6:
        // Progresso (implemente a rota se necessário)
        break;
      case 7:
        // Minha Conta (implemente a rota se necessário)
        break;
    }
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onPressed;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 38, color: Colors.grey[700]),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 