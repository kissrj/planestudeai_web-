import 'package:flutter/material.dart';
import '../landing_page.dart';

class Header extends StatelessWidget {
  final bool showLogin;
  final bool showSignup;
  final bool showHome;
  final GlobalKey? pricingSectionKey;

  const Header({
    Key? key,
    this.showLogin = true,
    this.showSignup = true,
    this.showHome = false,
    this.pricingSectionKey,
  }) : super(key: key);

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Text(
                "PlanEstudeAI",
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              // Navegação desktop
              if (isLargeScreen)
                Row(
                  children: [
                    if (showHome)
                      TextButton.icon(
                        onPressed: () => _navigate(context, '/'),
                        icon: const Icon(Icons.home, color: Colors.blue),
                        label: const Text("Home", style: TextStyle(color: Colors.blue)),
                      ),
                    if (!showHome) ...[
                      _HeaderLink(
                        text: "Início",
                        onTap: () => _navigate(context, '/'),
                      ),
                      const SizedBox(width: 24),
                      _HeaderLink(
                        text: "Dashboard",
                        onTap: () => _navigate(context, '/dashboard'),
                      ),
                      const SizedBox(width: 24),
                      _HeaderLink(
                        text: "Planos",
                        onTap: () {
                          final contextSection = pricingSectionKey?.currentContext;
                          if (contextSection != null) {
                            Scrollable.ensureVisible(
                              contextSection,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _navigate(context, '/subscription');
                          }
                        },
                      ),
                      const SizedBox(width: 32),
                      if (showLogin)
                        OutlinedButton(
                          onPressed: () => _navigate(context, '/login'),
                          child: const Text("Entrar"),
                        ),
                      if (showSignup)
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: ElevatedButton(
                            onPressed: () => _navigate(context, '/signup'),
                            child: const Text("Cadastre-se"),
                          ),
                        ),
                    ],
                  ],
                ),
              // Menu mobile (pode ser adaptado conforme necessário)
              if (!isLargeScreen)
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _HeaderLink({required this.text, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
} 