import 'package:flutter/material.dart';
import '../models/plan.dart';

class PricingTableSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Plan> plans;

  const PricingTableSection({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.plans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[700],
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;
                  int columns = 1;
                  if (maxWidth > 900) {
                    columns = 2;
                  }
                  double cardWidth = (maxWidth - 24 * (columns - 1)) / columns;
                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: plans.map((plan) => SizedBox(
                      width: cardWidth > 400 ? 400 : cardWidth, // limita largura máxima
                      child: Material(
                        elevation: plan.highlighted ? 6 : 2,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: plan.highlighted ? Colors.blue.shade800 : Colors.grey.shade200,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (plan.highlighted)
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade800,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Mais popular",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plan.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          plan.price,
                                          style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade800,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "/${plan.period}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      plan.description,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: plan.features.map((feature) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: feature.included ? Colors.blue.shade800 : Colors.grey.shade400,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Flexible(
                                                child: Text(
                                                  feature.text,
                                                  style: TextStyle(
                                                    color: feature.included ? Colors.black87 : Colors.grey,
                                                    decoration: feature.included ? null : TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 32),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: plan.highlighted
                                            ? ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue.shade800,
                                                foregroundColor: Colors.white,
                                              )
                                            : OutlinedButton.styleFrom(
                                                foregroundColor: Colors.blue.shade800,
                                                side: BorderSide(color: Colors.blue.shade800),
                                              ),
                                        onPressed: () {},
                                        child: Text(plan.buttonText),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 