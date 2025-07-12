import 'package:flutter/material.dart';

class DashboardFeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? route;
  final String? description;
  final bool isDisabled;
  final Color? iconColor;

  const DashboardFeatureCard({
    super.key,
    required this.title,
    required this.icon,
    this.route,
    this.description,
    this.isDisabled = false,
    this.iconColor,
  });

  // Construtor para cards desabilitados
  const DashboardFeatureCard.disabled({
    super.key,
    required this.title,
    required this.icon,
  })  : route = null,
        description = null,
        isDisabled = true,
        iconColor = null;

  @override
  Widget build(BuildContext context) {
    final defaultIconColor = iconColor ?? _getDefaultIconColor(title);
    final effectiveIconColor = isDisabled ? Colors.grey[400] : defaultIconColor;

    return Card(
      elevation: isDisabled ? 1 : 2,
      color: isDisabled ? Colors.grey[50] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: effectiveIconColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDisabled ? Colors.grey[600] : Colors.grey[900],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (description != null) ...[
              Text(
                description!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDisabled ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
            ],
            SizedBox(
              width: double.infinity,
              child: isDisabled
                  ? OutlinedButton(
                      onPressed: null,
                      child: Text(_getButtonText(title)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        if (route != null) {
                          Navigator.pushNamed(context, route!);
                        }
                      },
                      child: Text(_getButtonText(title)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: defaultIconColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDefaultIconColor(String title) {
    switch (title.toLowerCase()) {
      case 'agenda de estudos':
        return Colors.blue[600]!;
      case 'plano de estudo':
        return Colors.green[600]!;
      case 'flashcards':
        return Colors.purple[600]!;
      case 'pomodoro':
        return Colors.orange[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  String _getButtonText(String title) {
    switch (title.toLowerCase()) {
      case 'agenda de estudos':
        return 'Configurar Agenda';
      case 'plano de estudo':
        return 'Ver Plano';
      case 'flashcards':
        return 'Ver Flashcards';
      case 'pomodoro':
        return 'Usar Pomodoro';
      default:
        return 'Acessar';
    }
  }
} 