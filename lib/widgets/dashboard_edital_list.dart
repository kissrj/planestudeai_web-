import 'package:flutter/material.dart';
import 'dashboard_summary_card.dart'; // Para usar as classes Edital, Cargo, Disciplina

class DashboardEditalList extends StatelessWidget {
  final List<Edital> editais;

  const DashboardEditalList({
    super.key,
    required this.editais,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seus Editais',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: editais.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final edital = editais[index];
                return _buildEditalItem(context, edital);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditalItem(BuildContext context, Edital edital) {
    final totalDisciplinas = edital.cargos.fold<int>(
      0,
      (acc, cargo) => acc + cargo.disciplinas.length,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edital.nome,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Criado em: ${_formatDate(edital.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (edital.dataProva != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Prova: ${_formatDate(edital.dataProva!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${edital.cargos.length} cargos',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$totalDisciplinas disciplinas',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
} 