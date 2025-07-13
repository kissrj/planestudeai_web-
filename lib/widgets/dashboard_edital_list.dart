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

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 240, maxWidth: 360),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 8 : 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 16,
          runSpacing: 8,
          children: [
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    edital.nome,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Criado em: ${_formatDate(edital.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (edital.dataProva != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Prova: ${_formatDate(edital.dataProva!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue[600],
                      ),
                      overflow: TextOverflow.ellipsis,
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
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$totalDisciplinas disciplinas',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
} 