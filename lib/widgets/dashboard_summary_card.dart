import 'package:flutter/material.dart';

class Edital {
  final String id;
  final String nome;
  final DateTime createdAt;
  final DateTime? dataProva;
  final List<Cargo> cargos;
  final String? observacoes;

  Edital({
    required this.id,
    required this.nome,
    required this.createdAt,
    this.dataProva,
    required this.cargos,
    this.observacoes,
  });
}

class Cargo {
  final String nome;
  final List<Disciplina> disciplinas;

  Cargo({required this.nome, required this.disciplinas});
}

class Disciplina {
  final String nome;

  Disciplina({required this.nome});
}

class DashboardSummaryCard extends StatelessWidget {
  final Edital edital;
  final int totalEditais;

  const DashboardSummaryCard({
    super.key,
    required this.edital,
    required this.totalEditais,
  });

  @override
  Widget build(BuildContext context) {
    final totalDisciplinas = edital.cargos.fold<int>(
      0,
      (acc, cargo) => acc + cargo.disciplinas.length,
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.description, color: Colors.blue[600], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Edital Atual: ${edital.nome}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    totalEditais.toString(),
                    'Editais Cadastrados',
                    Colors.blue[600]!,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    edital.cargos.length.toString(),
                    'Cargos',
                    Colors.green[600]!,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    totalDisciplinas.toString(),
                    'Disciplinas',
                    Colors.purple[600]!,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    edital.dataProva != null
                        ? '${edital.dataProva!.day}/${edital.dataProva!.month}/${edital.dataProva!.year}'
                        : 'Não informada',
                    'Data da Prova',
                    Colors.orange[600]!,
                  ),
                ),
              ],
            ),
            if (edital.observacoes != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Observações: ${edital.observacoes}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Widget para quando não há edital
class DashboardSummaryCardNoEdital extends StatelessWidget {
  const DashboardSummaryCardNoEdital({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description,
                size: 48,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Nenhum edital encontrado',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Para começar a usar o PlanEstudeAI, você precisa colar o edital do seu concurso. '
              'Nossa IA analisará o conteúdo e criará um plano de estudos personalizado para você.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navegar para upload de edital
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Colar Edital'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: null, // Desabilitado
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
    );
  }
} 