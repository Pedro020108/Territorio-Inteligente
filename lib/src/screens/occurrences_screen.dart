import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/territory_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/section_title.dart';

class OccurrencesScreen extends StatefulWidget {
  const OccurrencesScreen({super.key});
  @override State<OccurrencesScreen> createState() => _OccurrencesScreenState();
}
class _OccurrencesScreenState extends State<OccurrencesScreen> {
  final formKey = GlobalKey<FormState>();
  final areaController = TextEditingController();
  final descriptionController = TextEditingController();
  String category = 'Resíduos';
  final categories = ['Resíduos', 'Água', 'Energia', 'Iluminação', 'Mobilidade', 'Área verde', 'Outro'];

  @override void dispose() { areaController.dispose(); descriptionController.dispose(); super.dispose(); }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    await context.read<TerritoryProvider>().addOccurrence(category: category, area: areaController.text.trim(), description: descriptionController.text.trim());
    areaController.clear(); descriptionController.clear();
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorrência registrada com sucesso.')));
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<TerritoryProvider>().occurrences;
    return Scaffold(body: ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 30), children: [
      const SectionTitle('Ocorrências territoriais', subtitle: 'Registre situações observadas pela equipe'),
      const SizedBox(height: 16),
      Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Form(key: formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Nova ocorrência', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.navy)),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(value: category, decoration: const InputDecoration(labelText: 'Categoria'),
            items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => category = v ?? category)),
          const SizedBox(height: 12),
          TextFormField(controller: areaController, decoration: const InputDecoration(labelText: 'Bairro ou setor', prefixIcon: Icon(Icons.place_outlined)),
            validator: (v) => v == null || v.trim().length < 2 ? 'Informe uma área válida.' : null),
          const SizedBox(height: 12),
          TextFormField(controller: descriptionController, maxLines: 3, decoration: const InputDecoration(labelText: 'Descrição', alignLabelWithHint: true),
            validator: (v) => v == null || v.trim().length < 10 ? 'Descreva a ocorrência com pelo menos 10 caracteres.' : null),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: submit, icon: const Icon(Icons.add), label: const Text('Registrar ocorrência'))),
        ]))),
      const SizedBox(height: 22),
      const SectionTitle('Histórico', subtitle: 'Registros salvos neste dispositivo'),
      const SizedBox(height: 10),
      if (items.isEmpty) Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: const Text('Nenhuma ocorrência registrada. Use o formulário acima para adicionar a primeira.', style: TextStyle(color: AppTheme.muted, fontSize: 12))),
      ...items.map((o) => Container(margin: const EdgeInsets.only(bottom: 9), padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.assignment_outlined, color: AppTheme.blue), const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(o.category, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navy)),
            Text(o.area, style: const TextStyle(fontSize: 11, color: AppTheme.muted)),
            const SizedBox(height: 5), Text(o.description, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 5), Text(o.date, style: const TextStyle(fontSize: 10, color: AppTheme.muted)),
          ])),
        ]))),
    ]));
  }
}
