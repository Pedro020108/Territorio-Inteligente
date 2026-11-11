import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/territory_models.dart';
import '../providers/territory_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/section_title.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});
  Color color(RiskLevel risk) => switch (risk) { RiskLevel.critico => AppTheme.red, RiskLevel.alto => AppTheme.red, RiskLevel.moderado => AppTheme.orange, RiskLevel.baixo => AppTheme.teal };
  String label(RiskLevel risk) => switch (risk) { RiskLevel.critico => 'Crítico', RiskLevel.alto => 'Alto', RiskLevel.moderado => 'Moderado', RiskLevel.baixo => 'Baixo' };
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TerritoryProvider>();
    final alerts = provider.alerts;
    return Scaffold(body: ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 30), children: [
      const SectionTitle('Central de alertas', subtitle: 'Sinais para apoiar a análise do gestor'),
      const SizedBox(height: 8),
      Text('${alerts.where((a) => !a.isResolved).length} alertas aguardando avaliação', style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
      const SizedBox(height: 16),
      ...alerts.map((a) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: color(a.risk).withOpacity(.12), borderRadius: BorderRadius.circular(20)),
              child: Text(label(a.risk).toUpperCase(), style: TextStyle(color: color(a.risk), fontSize: 9, fontWeight: FontWeight.w800))),
            const Spacer(), Text(a.date, style: const TextStyle(color: AppTheme.muted, fontSize: 10)),
          ]),
          const SizedBox(height: 10),
          Text(a.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.navy)),
          const SizedBox(height: 4),
          Text(a.area, style: const TextStyle(fontSize: 11, color: AppTheme.muted)),
          const SizedBox(height: 10),
          Text(a.reason, style: const TextStyle(fontSize: 12, height: 1.4)),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.insights, size: 16, color: AppTheme.blue), const SizedBox(width: 6),
            Text('Confiança estimada: ${a.confidence}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 8),
          ExpansionTile(tilePadding: EdgeInsets.zero, childrenPadding: EdgeInsets.zero, title: const Text('Justificativa, limitações e orientação', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            children: [
              _detail('Limitações', a.limitation), _detail('Ação sugerida', a.recommendation),
            ]),
          if (!a.isResolved) Align(alignment: Alignment.centerRight, child: TextButton.icon(
            onPressed: () => context.read<TerritoryProvider>().resolveAlert(a.id),
            icon: const Icon(Icons.check_circle_outline), label: const Text('Marcar como avaliado'))),
          if (a.isResolved) const Align(alignment: Alignment.centerRight, child: Chip(label: Text('Avaliado pelo gestor'), avatar: Icon(Icons.check, size: 16))),
        ]))),
    ]));
  }
  Widget _detail(String title, String body) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.blue)),
    const SizedBox(height: 3), Text(body, style: const TextStyle(fontSize: 11, height: 1.4)),
  ]));
}
