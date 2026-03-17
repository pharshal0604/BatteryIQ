import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// GENERIC DROPDOWN — works with any type T
// ═══════════════════════════════════════════════

class AppDropdown<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T? value;
  final List<DropdownMenuEntry<T>> entries;
  final ValueChanged<T?> onSelected;
  final bool hasError;
  final String? errorText;
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.entries,
    required this.onSelected,
    this.hasError = false,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError
        ? AppColors.error
        : Theme.of(context).dividerColor;

    final labelColor = Theme.of(context).textTheme.bodySmall?.color;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: DropdownMenu<T>(
                initialSelection: value,
                width: constraints.maxWidth,
                enabled: enabled,
                label: Text(
                  label,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: labelColor,
                  ),
                ),
                leadingIcon: Icon(
                  icon,
                  color: enabled
                      ? AppColors.brandGreen
                      : Theme.of(context).disabledColor,
                  size: 20,
                ),
                dropdownMenuEntries: entries,
                onSelected: onSelected,
                menuStyle: MenuStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  elevation: const WidgetStatePropertyAll(4),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: GoogleFonts.lato(
                    fontSize: 14,
                    color: labelColor,
                  ),
                  hintStyle: GoogleFonts.lato(
                    fontSize: 14,
                    color: labelColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),

                  // Default border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: borderColor),
                  ),

                  // Focused border
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.brandGreen,
                      width: 2,
                    ),
                  ),

                  // Disabled border
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Theme.of(context).disabledColor.withValues(alpha: 0.3),
                    ),
                  ),

                  // Error borders
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.error,
                      width: 2,
                    ),
                  ),

                  filled: true,
                  fillColor: enabled
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).disabledColor.withValues(alpha: 0.05),
                ),
              ),
            ),

            // Inline error text — only shown when hasError + errorText given
            if (hasError && errorText != null) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  errorText!,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════
// PRESET DROPDOWNS — ready-to-use for fleet screens
// ═══════════════════════════════════════════════

/// Vehicle status filter: ALL / HEALTHY / ATTENTION / CRITICAL
class VehicleStatusDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onSelected;

  const VehicleStatusDropdown({
    super.key,
    required this.value,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<String>(
      label: 'Filter by Status',
      icon: Icons.filter_list_rounded,
      value: value,
      onSelected: onSelected,
      entries: const [
        DropdownMenuEntry(value: 'ALL',       label: 'All Vehicles'),
        DropdownMenuEntry(value: 'HEALTHY',   label: '✅  Healthy'),
        DropdownMenuEntry(value: 'ATTENTION', label: '⚠️  Needs Attention'),
        DropdownMenuEntry(value: 'CRITICAL',  label: '🔴  Critical'),
      ],
    );
  }
}

/// Trend time range: 7D / 30D / 90D / 1Y
class TrendRangeDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onSelected;

  const TrendRangeDropdown({
    super.key,
    required this.value,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<String>(
      label: 'Time Range',
      icon: Icons.date_range_outlined,
      value: value,
      onSelected: onSelected,
      entries: const [
        DropdownMenuEntry(value: '7D',  label: 'Last 7 Days'),
        DropdownMenuEntry(value: '30D', label: 'Last 30 Days'),
        DropdownMenuEntry(value: '90D', label: 'Last 90 Days'),
        DropdownMenuEntry(value: '1Y',  label: 'Last 1 Year'),
      ],
    );
  }
}

/// Stress level filter: ALL / LOW / MEDIUM / HIGH
class StressLevelDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onSelected;

  const StressLevelDropdown({
    super.key,
    required this.value,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdown<String>(
      label: 'Driving Stress',
      icon: Icons.speed_outlined,
      value: value,
      onSelected: onSelected,
      entries: const [
        DropdownMenuEntry(value: 'ALL',    label: 'All Levels'),
        DropdownMenuEntry(value: 'LOW',    label: '🟢  Low Stress'),
        DropdownMenuEntry(value: 'MEDIUM', label: '🟡  Medium Stress'),
        DropdownMenuEntry(value: 'HIGH',   label: '🔴  High Stress'),
      ],
    );
  }
}
