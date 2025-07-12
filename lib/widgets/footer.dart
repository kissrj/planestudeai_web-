import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Grid de links (agora usando Wrap)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isLargeScreen = constraints.maxWidth > 900;
                  double cardWidth = isLargeScreen
                      ? (constraints.maxWidth - 32 * 3) / 4
                      : constraints.maxWidth;
                  return Wrap(
                    spacing: 32,
                    runSpacing: 24,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "PlanEstudeAI",
                              style: TextStyle(
                                color: Color(0xFF1E40AF),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Planos personalizados de estudo para concursos públicos com ajuda da IA.",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _FooterLinks(
                          title: "Produto",
                          links: [
                            "Como funciona",
                            "Planos e preços",
                            "Depoimentos",
                          ],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _FooterLinks(
                          title: "Suporte",
                          links: [
                            "Central de Ajuda",
                            "Contato",
                            "FAQ",
                          ],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _FooterLinks(
                          title: "Legal",
                          links: [
                            "Termos de Serviço",
                            "Política de Privacidade",
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              Divider(color: Colors.grey),
              const SizedBox(height: 16),
              // Copyright e redes sociais
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "© $year PlanEstudeAI. Todos os direitos reservados.",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.alternate_email),
                        color: Colors.grey,
                        onPressed: () {}, // Twitter
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.grey,
                        onPressed: () {}, // Instagram
                      ),
                      IconButton(
                        icon: const Icon(Icons.facebook),
                        color: Colors.grey,
                        onPressed: () {}, // Facebook
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterLinks({required this.title, required this.links, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: InkWell(
                onTap: () {
                  // Navegação para a página correspondente
                },
                child: Text(
                  link,
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
            )),
      ],
    );
  }
} 