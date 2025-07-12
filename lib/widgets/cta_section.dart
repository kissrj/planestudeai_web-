import 'package:flutter/material.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade800,
      padding: const EdgeInsets.symmetric(vertical: 48),
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                "Pronto para começar sua jornada de aprovação?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                "Junte-se a milhares de candidatos que estão organizando seus estudos de forma inteligente.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue[50],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 260,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue.shade800,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text("Comece agora gratuitamente"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 