import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/territory_models.dart';
import '../services/weather_service.dart';
import 'package:flutter/material.dart';

class TerritoryProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherData? weather;
  bool weatherLoading = false;
  String? weatherError;
  List<Occurrence> occurrences = [];

  final List<TerritoryAlert> alerts = [
    const TerritoryAlert(id:'A-001', title:'Consumo de água acima da média', area:'Zona Leste · Setor 04',
      reason:'O consumo simulado está 18% acima da média dos últimos 30 dias. A tendência pode indicar vazamento ou aumento atípico da demanda.',
      limitation:'A leitura é baseada em dados demonstrativos agregados. Não identifica imóveis nem confirma vazamentos.',
      recommendation:'Verificar os dados operacionais do setor e priorizar uma inspeção técnica por amostragem.',
      date:'Hoje, 09:15', risk:RiskLevel.alto, confidence:82),
    const TerritoryAlert(id:'A-002', title:'Atenção para acúmulo de resíduos', area:'Centro · Setor 02',
      reason:'O volume estimado de resíduos está próximo do limite de capacidade definido para o cenário de demonstração.',
      limitation:'A estimativa não substitui a pesagem nem a vistoria presencial. Eventos locais podem alterar a demanda.',
      recommendation:'Avaliar reforço temporário da coleta e confirmar a situação com a equipe de campo.',
      date:'Hoje, 08:40', risk:RiskLevel.moderado, confidence:74),
    const TerritoryAlert(id:'A-003', title:'Possível pressão sobre energia', area:'Zona Sul · Setor 07',
      reason:'A série sintética apresenta crescimento de 12% no consumo em relação à semana anterior.',
      limitation:'Não há telemetria de concessionária conectada. O indicador é ilustrativo e não representa medição oficial.',
      recommendation:'Acompanhar a tendência e comparar com temperatura e calendário de eventos.',
      date:'Ontem, 17:20', risk:RiskLevel.baixo, confidence:68),
  ];

  final List<Indicator> indicators = const [
    Indicator(title:'Consumo de água', value:'18%', unit:'acima da média', change:'+8% na semana', description:'Consumo estimado', progress:.78, icon:Icons.water_drop_outlined, risk:RiskLevel.alto),
    Indicator(title:'Energia', value:'12%', unit:'de aumento', change:'+3% na semana', description:'Demanda estimada', progress:.62, icon:Icons.bolt_outlined, risk:RiskLevel.moderado),
    Indicator(title:'Resíduos', value:'76%', unit:'da capacidade', change:'+5% na semana', description:'Capacidade utilizada', progress:.76, icon:Icons.recycling_outlined, risk:RiskLevel.moderado),
    Indicator(title:'Áreas verdes', value:'64%', unit:'de cobertura', change:'Estável', description:'Índice territorial', progress:.64, icon:Icons.park_outlined, risk:RiskLevel.baixo),
  ];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('territory_occurrences');
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      occurrences = list.map((e) => Occurrence.fromJson(Map<String, dynamic>.from(e))).toList();
    }
  }

  Future<void> refreshWeather() async {
    weatherLoading = true; weatherError = null; notifyListeners();
    try { weather = await _weatherService.fetchCurrent(); }
    catch (_) { weatherError = 'Clima indisponível. Verifique a conexão e tente novamente.'; }
    finally { weatherLoading = false; notifyListeners(); }
  }

  Future<void> addOccurrence({required String category, required String area, required String description}) async {
    final item = Occurrence(id: DateTime.now().microsecondsSinceEpoch.toString(),
      category: category, area: area, description: description,
      date: DateTime.now().toString().substring(0, 16));
    occurrences.insert(0, item);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('territory_occurrences', jsonEncode(occurrences.map((e) => e.toJson()).toList()));
    notifyListeners();
  }

  void resolveAlert(String id) {
    final index = alerts.indexWhere((a) => a.id == id);
    if (index >= 0) { alerts[index] = alerts[index].copyWith(isResolved: true); notifyListeners(); }
  }
}
