import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/features_section.dart';
import 'widgets/how_it_works_section.dart';
import 'widgets/testimonials_section.dart';
import 'widgets/pricing_table_section.dart';
import 'widgets/cta_section.dart';
import 'models/feature.dart';
import 'models/step_data.dart';
import 'models/testimonial.dart';
import 'models/plan.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      Feature(
        title: "Cronograma Automático",
        description: "Gere um plano de estudos personalizado com base no edital do seu concurso e na sua disponibilidade de horários.",
      ),
      Feature(
        title: "Revisões Inteligentes",
        description: "O sistema programa revisões estratégicas usando a técnica 24h/7d/30d para maximizar sua retenção de conteúdo.",
      ),
      Feature(
        title: "Plano 100% Adaptável",
        description: "Reorganize seu cronograma automaticamente quando imprevistos acontecem, sem perder o foco nas prioridades.",
      ),
    ];

    final steps = [
      StepData(
        icon: Icons.insert_drive_file,
        title: "Cole o edital",
        description: "Insira o texto do edital do concurso e nossa IA analisará as disciplinas, pesos e conteúdo programático.",
      ),
      StepData(
        icon: Icons.calendar_today,
        title: "Configure sua agenda",
        description: "Informe sua disponibilidade de horários e prioridades para personalizar completamente seu plano.",
      ),
      StepData(
        icon: Icons.lightbulb_outline,
        title: "Estude com eficiência",
        description: "Receba um plano otimizado com revisões programadas e acesse seu progresso em tempo real.",
      ),
    ];

    final testimonials = [
      Testimonial(
        quote: "O PlanEstudeAI revolucionou minha preparação. Consegui organizar meus estudos de forma eficiente e fui aprovado em primeiro lugar!",
        author: "Carlos Silva",
        role: "Aprovado na Polícia Federal",
      ),
      Testimonial(
        quote: "Antes eu perdia horas tentando montar meu cronograma. Com o PlanEstudeAI, ganhei tempo de estudo e organização mental.",
        author: "Ana Oliveira",
        role: "Aprovada no TRF",
      ),
      Testimonial(
        quote: "O sistema de revisões foi o diferencial na minha aprovação. A ferramenta me ajudou a nunca esquecer de revisar os conteúdos no tempo certo.",
        author: "Marcelo Santos",
        role: "Aprovado no TCU",
      ),
    ];

    final plans = [
      Plan(
        name: "Gratuito",
        price: "R\$0",
        period: "sempre",
        description: "Experimente por 7 dias e comprove os resultados",
        features: [
          PlanFeature(text: "1 plano de estudos", included: true),
          PlanFeature(text: "Análise básica de edital", included: true),
          PlanFeature(text: "Revisões programadas", included: true),
          PlanFeature(text: "Histórico de desempenho", included: false),
          PlanFeature(text: "Exportação em PDF", included: false),
          PlanFeature(text: "Suporte por e-mail", included: false),
        ],
        buttonText: "Começar gratuitamente",
        highlighted: false,
      ),
      Plan(
        name: "Premium",
        price: "R\$29",
        period: "mês",
        description: "Tudo que você precisa para sua aprovação",
        features: [
          PlanFeature(text: "Planos ilimitados", included: true),
          PlanFeature(text: "Análise avançada de edital", included: true),
          PlanFeature(text: "Revisões programadas", included: true),
          PlanFeature(text: "Histórico de desempenho", included: true),
          PlanFeature(text: "Exportação em PDF", included: true),
          PlanFeature(text: "Suporte por e-mail", included: true),
        ],
        buttonText: "Assinar agora",
        highlighted: true,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: const Header(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroSection(),
            FeaturesSection(
              title: "Por que usar o PlanEstudeAI?",
              subtitle: "Recursos exclusivos para otimizar seus estudos",
              features: features,
            ),
            HowItWorksSection(
              title: "Como funciona",
              subtitle: "Seu plano de estudos em apenas 3 passos simples",
              steps: steps,
            ),
            TestimonialsSection(
              title: "Depoimentos de aprovados",
              subtitle: "Veja o que nossos usuários estão dizendo",
              testimonials: testimonials,
            ),
            PricingTableSection(
              title: "Planos e preços",
              subtitle: "Escolha o plano perfeito para sua preparação",
              plans: plans,
            ),
            const CtaSection(),
            const Footer(),
          ],
        ),
      ),
    );
  }
} 