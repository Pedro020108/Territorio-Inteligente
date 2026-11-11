import 'package:flutter/material.dart';
import '../models/territory_models.dart';
import '../theme/app_theme.dart';

class MetricCard extends StatelessWidget {
  final Indicator item;
  const MetricCard({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    final color = item.risk == RiskLevel.alto ? AppTheme.red : item.risk == RiskLevel.moderado ? AppTheme.orange : AppTheme.teal;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(item.icon, color: AppTheme.blue), const Spacer(), Icon(Icons.circle, size: 9, color: color)]),
        const SizedBox(height: 14),
        Text(item.value, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: AppTheme.navy)),
        Text(item.unit, style: const TextStyle(fontSize: 11, color: AppTheme.muted)),
        const SizedBox(height: 10),
        Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        const SizedBox(height: 4),
        Text(item.change, style: TextStyle(fontSize: 11, color: color)),
        const SizedBox(height: 10),
        ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: item.progress, minHeight: 6, color: color, backgroundColor: const Color(0xFFE9EEF2))),
      ]),
    );
  }
}
