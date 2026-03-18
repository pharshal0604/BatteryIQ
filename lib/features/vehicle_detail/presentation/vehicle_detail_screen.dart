import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:ev_fleet_app/core/widgets/app_bar_title.dart';
import 'package:ev_fleet_app/core/widgets/empty_state_widget.dart';
import 'package:ev_fleet_app/core/widgets/error_retry_widget.dart';
import 'package:ev_fleet_app/core/widgets/loading_shimmer.dart';
import 'package:ev_fleet_app/core/widgets/section_card.dart';
import 'package:ev_fleet_app/core/widgets/soh_circle.dart';
import 'package:ev_fleet_app/core/widgets/stress_badge.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/regen_data_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/models/vehicle_detail_model.dart';
import 'package:ev_fleet_app/features/vehicle_detail/providers/vehicle_detail_provider.dart';
import 'package:ev_fleet_app/features/vehicle_detail/repository/vehicle_detail_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDetailScreen extends ConsumerWidget {
  final String vehicleId;

  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(vehicleDetailProvider(vehicleId));

    return Scaffold(
      appBar: _buildAppBar(context, detailAsync),
      body: detailAsync.when(
        loading: () => const VehicleDetailShimmer(),
        error: (e, _) => VehicleDetailErrorWidget(
          onRetry: () => ref.refresh(vehicleDetailProvider(vehicleId)),
        ),
        data: (detail) => RefreshIndicator(
          color: AppColors.brandGreen,
          onRefresh: () async {
            ref.refresh(vehicleDetailProvider(vehicleId));
            ref.refresh(vehicleTrendProvider(vehicleId));
            ref.refresh(vehicleStressProvider(vehicleId));
            ref.refresh(vehicleRegenProvider(vehicleId));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // ── 1. Health & RUL ───────────────────
                HealthSectionCard(
                  child: _HealthSection(detail: detail),
                ),

                // ── 2. Degradation Trend ──────────────
                TrendSectionCard(
                  trailing: _TrendRangeSelector(vehicleId: vehicleId),
                  child: _TrendSection(vehicleId: vehicleId),
                ),

                // ── 3. Driving Stress ─────────────────
                StressSectionCard(
                  child: _StressSection(
                    vehicleId: vehicleId,
                    stressLevel: detail.stressLevel,
                  ),
                ),

                // ── 4. Regeneration ───────────────────
                RegenSectionCard(
                  child: _RegenSection(vehicleId: vehicleId),
                ),

                // ── Metrics Footer ────────────────────
                _MetricsFooter(detail: detail),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================================
  // APP BAR
  // ==========================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AsyncValue<VehicleDetailModel> detailAsync,
  ) {
    return AppBar(
      title: AppBarTitle(
        title: vehicleId,
        subtitle: detailAsync.value?.statusLabel,
        subtitleColor: detailAsync.value != null
            ? AppColors.fromStatus(detailAsync.value!.status)
            : null,
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// SECTION 1 — HEALTH & RUL
// ═══════════════════════════════════════════════

class _HealthSection extends StatelessWidget {
  final VehicleDetailModel detail;

  const _HealthSection({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SoH Circle — hero
        Center(child: SoHCircleLarge(soh: detail.soh)),
        const SizedBox(height: 20),

        // RUL Row
        _MetricRow(
          icon: Icons.timer_outlined,
          label: 'Remaining Useful Life',
          value: detail.rulDisplay,
          color: AppColors.fromSoH(detail.soh),
        ),
        const Divider(height: 20),

        // Total Cycles Row
        _MetricRow(
          icon: Icons.loop_rounded,
          label: 'Total Charge Cycles',
          value: '${detail.totalCycles}',
        ),
        const Divider(height: 20),

        // Last Charge Row
        _MetricRow(
          icon: Icons.battery_charging_full_rounded,
          label: 'Last Charge Level',
          value: detail.lastChargeDisplay,
        ),
        const Divider(height: 20),

        // Avg Temperature Row
        _MetricRow(
          icon: Icons.thermostat_rounded,
          label: 'Avg Temperature',
          value: detail.tempDisplay,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// SECTION 2 — DEGRADATION TREND
// ═══════════════════════════════════════════════

class _TrendRangeSelector extends ConsumerWidget {
  final String vehicleId;

  const _TrendRangeSelector({required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(trendRangeProvider(vehicleId));

    // Compact chip row — 7D / 30D / 90D / 1Y
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: ['7D', '30D', '90D', '1Y'].map((r) {
        final isSelected = range == r;
        return GestureDetector(
          onTap: () =>
              ref.read(trendRangeProvider(vehicleId).notifier).state = r,
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.brandGreen
                  : AppColors.brandGreen.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              r,
              style: GoogleFonts.lato(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : AppColors.brandGreen,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TrendSection extends ConsumerWidget {
  final String vehicleId;

  const _TrendSection({required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendAsync = ref.watch(vehicleTrendProvider(vehicleId));

    return trendAsync.when(
      loading: () => const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.brandGreen,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (e, _) => ErrorRetryWidget(
        message: 'Failed to load trend.',
        onRetry: () => ref.refresh(vehicleTrendProvider(vehicleId)),
        size: ErrorSize.compact,
      ),
      data: (points) {
        if (points.isEmpty) return const NoTrendData();
        return _TrendChart(points: points);
      },
    );
  }
}

class _TrendChart extends StatelessWidget {
  final List<SoHTrendPoint> points;

  const _TrendChart({required this.points});

  @override
  Widget build(BuildContext context) {
    final minSoH = points.map((p) => p.soh).reduce((a, b) => a < b ? a : b);
    final maxSoH = points.map((p) => p.soh).reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Mini sparkline ─────────────────────────
        SizedBox(
          height: 80,
          child: CustomPaint(
            size: const Size(double.infinity, 80),
            painter: _SparklinePainter(
              points: points,
              color: AppColors.brandGreen,
              minSoH: minSoH,
              maxSoH: maxSoH,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── First / Last labels ───────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              points.first.date,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            Text(
              '${points.last.soh.toStringAsFixed(1)}% now',
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.fromSoH(points.last.soh),
              ),
            ),
            Text(
              points.last.date,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Sparkline custom painter ─────────────────────

class _SparklinePainter extends CustomPainter {
  final List<SoHTrendPoint> points;
  final Color color;
  final double minSoH;
  final double maxSoH;

  _SparklinePainter({
    required this.points,
    required this.color,
    required this.minSoH,
    required this.maxSoH,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final range = (maxSoH - minSoH).abs();
    final safeRange = range < 1 ? 1.0 : range;
    final pad = size.height * 0.1;

    // ── Fill path ──────────────────────────────────
    final fillPath = Path();
    final linePath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = pad +
          ((maxSoH - points[i].soh) / safeRange) * (size.height - pad * 2);

      if (i == 0) {
        fillPath.moveTo(x, y);
        linePath.moveTo(x, y);
      } else {
        fillPath.lineTo(x, y);
        linePath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    // Fill
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.fill,
    );

    // Line
    canvas.drawPath(
      linePath,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Last point dot
    final lastX = size.width;
    final lastY = pad +
        ((maxSoH - points.last.soh) / safeRange) * (size.height - pad * 2);
    canvas.drawCircle(
      Offset(lastX, lastY),
      4,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.points != points || old.color != color;
}

// ═══════════════════════════════════════════════
// SECTION 3 — DRIVING STRESS
// ═══════════════════════════════════════════════

class _StressSection extends ConsumerWidget {
  final String vehicleId;
  final String stressLevel;

  const _StressSection({
    required this.vehicleId,
    required this.stressLevel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stressAsync = ref.watch(vehicleStressProvider(vehicleId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Overall stress level ──────────────────
        StressLevelRow(
          level: stressLevel,
          description: 'Your driving impact',
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 14),

        // ── Insight bullets ───────────────────────
        stressAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppColors.brandGreen,
              strokeWidth: 2,
            ),
          ),
          error: (e, _) => ErrorRetryWidget(
            message: 'Failed to load stress insights.',
            onRetry: () => ref.refresh(vehicleStressProvider(vehicleId)),
            size: ErrorSize.compact,
          ),
          data: (insights) => Column(
            children: insights
                .map((i) => StressInsightTile(
                      message: i.message,
                      isAboveAverage: i.isAboveAverage,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// SECTION 4 — REGENERATION
// ═══════════════════════════════════════════════

class _RegenSection extends ConsumerWidget {
  final String vehicleId;

  const _RegenSection({required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regenAsync = ref.watch(vehicleRegenProvider(vehicleId));

    return regenAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColors.brandGreen,
          strokeWidth: 2,
        ),
      ),
      error: (e, _) => ErrorRetryWidget(
        message: 'Failed to load regen data.',
        onRetry: () => ref.refresh(vehicleRegenProvider(vehicleId)),
        size: ErrorSize.compact,
      ),
      data: (regen) => _RegenContent(regen: regen),
    );
  }
}

class _RegenContent extends StatelessWidget {
  final RegenDataModel regen;

  const _RegenContent({required this.regen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary sentence
        Text(
          regen.summaryText,
          style: GoogleFonts.lato(
            fontSize: 13,
            height: 1.5,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(height: 16),

        // ── Regen Bar ─────────────────────────────
        _RegenBar(
          usedKwh: regen.usedKwh,
          regenKwh: regen.regenKwh,
          progress: regen.regenBarProgress,
        ),
        const SizedBox(height: 16),

        // ── Used vs Regen stats ───────────────────
        Row(
          children: [
            Expanded(
              child: _RegenStat(
                label: 'Energy Used',
                value: regen.usedDisplay,
                color: Theme.of(context).colorScheme.onSurface,
                icon: Icons.bolt_outlined,
              ),
            ),
            Expanded(
              child: _RegenStat(
                label: 'Regenerated',
                value: regen.regenDisplay,
                color: AppColors.brandGreen,
                icon: Icons.replay_rounded,
              ),
            ),
            Expanded(
              child: _RegenStat(
                label: 'Regen Ratio',
                value: regen.regenRatioDisplay,
                color: AppColors.brandGreen,
                icon: Icons.percent_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RegenBar extends StatelessWidget {
  final double usedKwh;
  final double regenKwh;
  final double progress; // 0.0 – 1.0

  const _RegenBar({
    required this.usedKwh,
    required this.regenKwh,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Regen Efficiency',
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              '${(progress * 100).toStringAsFixed(1)}%',
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.brandGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Bar background
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Theme.of(context).dividerColor,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.brandGreen,
            ),
          ),
        ),
      ],
    );
  }
}

class _RegenStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _RegenStat({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 11,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════
// METRICS FOOTER — temp + cycles summary
// ═══════════════════════════════════════════════

class _MetricsFooter extends StatelessWidget {
  final VehicleDetailModel detail;

  const _MetricsFooter({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: _MetricRow(
                icon: Icons.thermostat_rounded,
                label: 'Avg Temp',
                value: detail.tempDisplay,
              ),
            ),
            Container(
              width: 1,
              height: 36,
              color: Theme.of(context).dividerColor,
            ),
            Expanded(
              child: _MetricRow(
                icon: Icons.loop_rounded,
                label: 'Cycles',
                value: '${detail.totalCycles}',
              ),
            ),
            Container(
              width: 1,
              height: 36,
              color: Theme.of(context).dividerColor,
            ),
            Expanded(
              child: _MetricRow(
                icon: Icons.battery_full_rounded,
                label: 'Last Charge',
                value: detail.lastChargeDisplay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// METRIC ROW — icon + label + value
// ═══════════════════════════════════════════════

class _MetricRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _MetricRow({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final valueColor = color ?? Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.brandGreen,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.lato(
                    fontSize: 11,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
