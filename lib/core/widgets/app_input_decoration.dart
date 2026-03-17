import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// BASE INPUT DECORATION — reusable everywhere
// ═══════════════════════════════════════════════

InputDecoration appInputDecoration({
  required BuildContext context,
  required String label,
  required String hint,
  IconData? icon,
  Widget? suffixIcon,
  bool isMultiline = false,
  bool isSearch = false,   // search style — no label, grey bg
}) {
  final borderColor = Theme.of(context).dividerColor;
  final labelColor  = Theme.of(context).textTheme.bodySmall?.color;

  // Search fields use softer radius, others pill or card
  final borderRadius = isSearch
      ? 12.0
      : isMultiline
          ? 14.0
          : 14.0;

  final contentPadding = isMultiline
      ? const EdgeInsets.all(16)
      : isSearch
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 18);

  return InputDecoration(
    labelText: (label.isNotEmpty && !isSearch) ? label : null,
    hintText: hint,

    labelStyle: GoogleFonts.lato(
      fontSize: 14,
      color: labelColor,
    ),
    hintStyle: GoogleFonts.lato(
      fontSize: 14,
      color: labelColor,
    ),

    prefixIcon: icon != null
        ? Icon(
            icon,
            color: isSearch
                ? Theme.of(context).iconTheme.color
                : AppColors.brandGreen,
            size: 20,
          )
        : null,
    suffixIcon: suffixIcon,

    contentPadding: contentPadding,
    alignLabelWithHint: isMultiline,

    // Search uses filled bg, others transparent
    filled: isSearch,
    fillColor: isSearch
        ? Theme.of(context).colorScheme.surface
        : Colors.transparent,

    // Default border
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: isSearch
          ? BorderSide(color: borderColor)
          : BorderSide(color: borderColor),
    ),

    // Focused border
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: AppColors.brandGreen,
        width: 2,
      ),
    ),

    // Error borders
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),

    // Disabled border
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: Theme.of(context).disabledColor.withValues(alpha: 0.3),
      ),
    ),
  );
}
// ═══════════════════════════════════════════════
// PRESET FIELDS — ready-to-use for fleet screens
// ═══════════════════════════════════════════════

/// Vehicle search bar — used on Vehicle List Screen
class VehicleSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;

  const VehicleSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.lato(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: appInputDecoration(
        context: context,
        label: '',
        hint: 'Search vehicle ID...',
        icon: Icons.search_rounded,
        isSearch: true,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () {
                  controller.clear();
                  onClear?.call();
                  onChanged('');
                },
              )
            : null,
      ),
    );
  }
}

/// Notes / remarks multiline field — for future use
class NotesInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final int maxLines;

  const NotesInputField({
    super.key,
    required this.controller,
    this.label = 'Notes',
    this.hint = 'Add notes about this vehicle...',
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.lato(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: appInputDecoration(
        context: context,
        label: label ?? '',
        hint: hint ?? '',
        icon: Icons.notes_rounded,
        isMultiline: true,
      ),
    );
  }
}
