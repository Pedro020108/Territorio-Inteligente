import 'package:flutter/material.dart';

enum RiskLevel { baixo, moderado, alto, critico }

class Indicator {
  final String title, value, unit, change, description;
  final double progress;
  final IconData icon;
  final RiskLevel risk;
  const Indicator({required this.title, required this.value, required this.unit, required this.change,
    required this.description, required this.progress, required this.icon, required this.risk});
}

class TerritoryAlert {
  final String id, title, area, reason, limitation, recommendation, date;
  final RiskLevel risk;
  final int confidence;
  final bool isResolved;
  const TerritoryAlert({required this.id, required this.title, required this.area, required this.reason,
    required this.limitation, required this.recommendation, required this.date, required this.risk,
    required this.confidence, this.isResolved = false});

  TerritoryAlert copyWith({bool? isResolved}) => TerritoryAlert(
    id: id, title: title, area: area, reason: reason, limitation: limitation,
    recommendation: recommendation, date: date, risk: risk, confidence: confidence,
    isResolved: isResolved ?? this.isResolved);
}

class Occurrence {
  final String id, category, area, description, date;
  const Occurrence({required this.id, required this.category, required this.area, required this.description, required this.date});
  Map<String, dynamic> toJson() => {'id': id, 'category': category, 'area': area, 'description': description, 'date': date};
  factory Occurrence.fromJson(Map<String, dynamic> json) => Occurrence(
    id: json['id'], category: json['category'], area: json['area'],
    description: json['description'], date: json['date']);
}
