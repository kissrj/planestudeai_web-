class PlanFeature {
  final String text;
  final bool included;

  PlanFeature({required this.text, required this.included});
}

class Plan {
  final String name;
  final String price;
  final String period;
  final String description;
  final List<PlanFeature> features;
  final String buttonText;
  final bool highlighted;

  Plan({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.buttonText,
    this.highlighted = false,
  });
} 