import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// APP BAR TITLE — centralised two-line AppBar title
// Used on: all screens that show title + subtitle
//
// Variants:
//   AppBarTitle(title: 'Fleet Health', subtitle: '18 vehicles total')
//   AppBarTitle(title: 'Healthy Vehicles', subtitle: '12 vehicles')
//   AppBarTitle(title: 'VH-001', subtitle: 'Good', subtitleColor: AppColors.success)
//   AppBarTitle(title: 'Alerts')  ← subtitle optional
// ═══════════════════════════════════════════════

class AppBarTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? subtitleColor; // null → uses default faded foreground color

  const AppBarTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = Theme.of(context)
        .appBarTheme
        .foregroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize:   18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty)
          Text(
            subtitle!,
            style: GoogleFonts.lato(
              fontSize: 12,
              color: subtitleColor
                  ?? fgColor?.withValues(alpha: 0.7),
            ),
          ),
      ],
    );
  }
}