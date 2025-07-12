import 'package:flutter/material.dart';

class DashboardScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final int selectedIndex;
  final void Function(int)? onMenuTap;

  const DashboardScaffold({
    Key? key,
    required this.title,
    required this.child,
    this.selectedIndex = 0,
    this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Sidebar fixa
          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    'PlanEstudeAI',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                _SidebarItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  selected: selectedIndex == 0,
                  onTap: () => onMenuTap?.call(0),
                ),
                _SidebarItem(
                  icon: Icons.description,
                  label: 'Colar Edital',
                  selected: selectedIndex == 1,
                  onTap: () => onMenuTap?.call(1),
                ),
                _SidebarItem(
                  icon: Icons.calendar_today,
                  label: 'Config. Agenda',
                  selected: selectedIndex == 2,
                  onTap: () => onMenuTap?.call(2),
                ),
                _SidebarItem(
                  icon: Icons.menu_book,
                  label: 'Plano de Estudo',
                  selected: selectedIndex == 3,
                  onTap: () => onMenuTap?.call(3),
                ),
                _SidebarItem(
                  icon: Icons.style,
                  label: 'Revisão e Flashcards',
                  selected: selectedIndex == 4,
                  onTap: () => Navigator.of(context).pushNamed('/revisao-flashcards'),
                ),
                _SidebarItem(
                  icon: Icons.timer,
                  label: 'Gestor Pomodoro',
                  selected: selectedIndex == 5,
                  onTap: () => Navigator.of(context).pushNamed('/pomodoro'),
                ),
                _SidebarItem(
                  icon: Icons.bar_chart,
                  label: 'Progresso',
                  selected: selectedIndex == 6,
                  onTap: () => Navigator.of(context).pushNamed('/progresso'),
                ),
                _SidebarItem(
                  icon: Icons.person,
                  label: 'Minha Conta',
                  selected: selectedIndex == 7,
                  onTap: () => Navigator.of(context).pushNamed('/minha-conta'),
                ),
                const Spacer(),
                // Usuário e sair
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: const Text('J'), // Inicial de João
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('João da Silva', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed('/minha-conta'),
                              child: const Text(
                                'Ver perfil',
                                style: TextStyle(fontSize: 11, color: Colors.blue, decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16, top: 4),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed('/'),
                    borderRadius: BorderRadius.circular(6),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red[400], size: 18),
                        const SizedBox(width: 6),
                        Text('Sair', style: TextStyle(color: Colors.red[400], fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Conteúdo principal
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.blue[50] : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: selected ? Colors.blue[800] : Colors.grey[700], size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.blue[800] : Colors.grey[800],
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 