import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/territory_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/metric_card.dart';
import '../widgets/section_title.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final data = context.watch<TerritoryProvider>();
    return Scaffold(
      body: RefreshIndicator(onRefresh: () => data.refreshWeather(), child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        children: [
          Row(children: [
            Container(width: 42, height: 42, decoration: BoxDecoration(color: AppTheme.navy, borderRadius: BorderRadius.circular(13)),
              child: const Icon(Icons.location_city, color: Colors.white)),
            const SizedBox(width: 10),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('TERRITÓRIO INTELIGENTE', style: TextStyle(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w800, color: AppTheme.blue)),
              Text('Visão geral', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: AppTheme.navy)),
            ])),
            IconButton(onPressed: () => data.refreshWeather(), icon: const Icon(Icons.refresh)),
          ]),
          const SizedBox(height: 20),
          Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: AppTheme.navy, borderRadius: BorderRadius.circular(20)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('ÁREA MONITORADA', style: TextStyle(color: Color(0xFFB8D4E0), fontSize: 10, letterSpacing: 1.2)),
              const SizedBox(height: 5),
              const Text('São Paulo · SP', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(children: [
                const Icon(Icons.my_location, color: AppTheme.teal, size: 16),
                const SizedBox(width: 6),
                const Expanded(child: Text('Painel demonstrativo por setores territoriais', style: TextStyle(color: Colors.white70, fontSize: 11))),
                Text('${data.alerts.where((a) => !a.isResolved).length} alertas ativos', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
              ]),
            ])),
          const SizedBox(height: 22),
          const SectionTitle('Indicadores principais', subtitle: 'Dados demonstrativos para acompanhamento territorial'),
          const SizedBox(height: 12),
          GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            itemCount: data.indicators.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.17),
            itemBuilder: (_, i) => MetricCard(item: data.indicators[i])),
          const SizedBox(height: 22),
          const SectionTitle('Tendência de consumo', subtitle: 'Índice ilustrativo · últimos 7 dias'),
          const SizedBox(height: 12),
          Container(height: 210, padding: const EdgeInsets.fromLTRB(12, 18, 18, 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: LineChart(LineChartData(
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: _bottomTitle, interval: 1)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
              lineBarsData: [
                LineChartBarData(isCurved: true, color: AppTheme.blue, barWidth: 3, dotData: const FlDotData(show: false),
                  spots: const [FlSpot(0, 38),FlSpot(1,42),FlSpot(2,39),FlSpot(3,48),FlSpot(4,45),FlSpot(5,56),FlSpot(6,61)]),
                LineChartBarData(isCurved: true, color: AppTheme.teal, barWidth: 2, dotData: const FlDotData(show: false),
                  spots: const [FlSpot(0, 32),FlSpot(1,34),FlSpot(2,35),FlSpot(3,36),FlSpot(4,38),FlSpot(5,39),FlSpot(6,40)]),
              ],
            ))),
          const SizedBox(height: 10),
          const Row(children: [Icon(Icons.circle, color: AppTheme.blue, size: 9), SizedBox(width: 5), Text('Demanda observada (simulada)', style: TextStyle(fontSize: 10, color: AppTheme.muted)), SizedBox(width: 14), Icon(Icons.circle, color: AppTheme.teal, size: 9), SizedBox(width: 5), Text('Referência', style: TextStyle(fontSize: 10, color: AppTheme.muted))]),
          const SizedBox(height: 22),
          const SectionTitle('Condições climáticas', subtitle: 'Fonte: Open-Meteo · São Paulo'),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: data.weatherLoading ? const Center(child: CircularProgressIndicator()) :
            data.weather != null ? Row(children: [
              const Icon(Icons.cloud_outlined, size: 38, color: AppTheme.blue), const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${data.weather!.temperature.toStringAsFixed(1)} °C', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                Text('Umidade ${data.weather!.humidity}% · Vento ${data.weather!.windSpeed.toStringAsFixed(1)} km/h', style: const TextStyle(fontSize: 11, color: AppTheme.muted)),
              ])),
              const Icon(Icons.check_circle, color: AppTheme.teal),
            ]) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(data.weatherError ?? 'Consulte o clima atual.', style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
              TextButton.icon(onPressed: () => data.refreshWeather(), icon: const Icon(Icons.cloud_sync), label: const Text('Consultar clima')),
            ])),
          const SizedBox(height: 18),
          const Text('Atenção: indicadores de água, energia, resíduos e tendência são sintéticos. Não representam medições oficiais.', style: TextStyle(fontSize: 10, color: AppTheme.muted)),
        ],
      )),
    );
  }
  static Widget _bottomTitle(double value, TitleMeta meta) {
    const labels = ['Seg','Ter','Qua','Qui','Sex','Sáb','Dom'];
    final i = value.toInt();
    return SideTitleWidget(meta: meta, child: Text(i >= 0 && i < labels.length ? labels[i] : '', style: const TextStyle(fontSize: 10, color: AppTheme.muted)));
  }
}
