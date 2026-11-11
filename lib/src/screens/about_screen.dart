import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_title.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 30), children: [
    const SectionTitle('Sobre o projeto', subtitle: 'Cross-Platform Application Development · FIAP'),
    const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: AppTheme.navy, borderRadius: BorderRadius.circular(18)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.public, color: AppTheme.teal, size: 34),
        SizedBox(height: 12),
        Text('Território Inteligente', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Um painel de apoio à análise territorial. O aplicativo organiza indicadores, apresenta tendências e ajuda gestores a priorizar verificações humanas.', style: TextStyle(color: Colors.white70, height: 1.5, fontSize: 12)),
      ])),
    const SizedBox(height: 18),
    _info('Fontes de dados', 'Clima: Open-Meteo (API pública). Água, energia, resíduos, áreas verdes e séries históricas: dados sintéticos criados exclusivamente para demonstração.'),
    _info('Limitações', 'Os indicadores sintéticos não representam medições oficiais nem permitem inferir condições reais de um bairro. Os alertas são regras demonstrativas, não previsões validadas em campo.'),
    _info('Privacidade', 'O formulário não solicita nome, telefone, endereço residencial ou identificação de cidadãos. As ocorrências ficam armazenadas localmente no dispositivo.'),
    _info('Uso responsável', 'O app não toma decisões automaticamente. Alertas são sinais para análise humana; qualquer ação exige verificação por profissionais responsáveis.'),
    _info('Tecnologias', 'Flutter, Dart, Provider, fl_chart, HTTP, Open-Meteo e SharedPreferences.'),
    const SizedBox(height: 12),
    const Text('Integrantes: preencher nomes completos e RMs da equipe antes da entrega.', style: TextStyle(fontSize: 11, color: AppTheme.muted)),
  ]));
  Widget _info(String title, String body) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.blue)),
      const SizedBox(height: 5), Text(body, style: const TextStyle(fontSize: 12, height: 1.45)),
    ]));
}
