import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  const SectionTitle(this.title, {super.key, this.subtitle});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.navy)),
    if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: const TextStyle(color: AppTheme.muted, fontSize: 12))],
  ]);
}
