import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:territorio_inteligente/main.dart';
import 'package:territorio_inteligente/src/providers/territory_provider.dart';
 
void main() {
  testWidgets('Abre o painel e navega até a central de alertas', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TerritoryProvider(),
        child: const TerritorioApp(),
      ),
    );
 
    expect(find.text('Visão geral'), findsOneWidget);
    expect(find.text('Indicadores principais'), findsOneWidget);
 
    await tester.tap(find.text('Alertas'));
    await tester.pumpAndSettle();
 
    expect(find.text('Central de alertas'), findsOneWidget);
    expect(find.text('Consumo de água acima da média'), findsOneWidget);
  });
}