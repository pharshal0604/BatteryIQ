import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ═══════════════════════════════════════════════
// LOADING SHIMMER — skeleton loaders
// Used on: all 3 screens while API is fetching
// Rule: follows ArchFlow theme pattern —
//       no isDark checks, uses theme tokens only
// ═══════════════════════════════════════════════

// ── Base shimmer wrapper ─────────────────────────

class _ShimmerWrapper extends StatelessWidget {
  final Widget child;

  const _ShimmerWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:      Theme.of(context).dividerColor,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: child,
    );
  }
}

// ── Base shimmer box ─────────────────────────────

class _ShimmerBox extends StatelessWidget {
  final double height;
  final double? width;
  final double radius;

  const _ShimmerBox({
    required this.height,
    this.width,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:      height,
      width:       width ?? double.infinity,
      decoration:  BoxDecoration(
        color:        Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// DASHBOARD SHIMMER
// Matches: 3 stat cards + vehicle list preview
// ═══════════════════════════════════════════════

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _ShimmerWrapper(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 3 Stat Cards ──────────────────────
            Row(
              children: [
                _shimmerStatCard(),
                const SizedBox(width: 10),
                _shimmerStatCard(),
                const SizedBox(width: 10),
                _shimmerStatCard(),
              ],
            ),
            const SizedBox(height: 24),

            // ── Section title ─────────────────────
            const _ShimmerBox(height: 18, width: 140),
            const SizedBox(height: 14),

            // ── Vehicle tiles ─────────────────────
            ...List.generate(5, (_) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _shimmerVehicleTile(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _shimmerStatCard() {
    return Expanded(
      child: Container(
        height:      120,
        decoration: BoxDecoration(
          color:        Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _shimmerVehicleTile() {
    return Container(
      height:      76,
      decoration:  BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// VEHICLE LIST SHIMMER
// Matches: filter chips row + list tiles
// ═══════════════════════════════════════════════

class VehicleListShimmer extends StatelessWidget {
  const VehicleListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _ShimmerWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Filter chips ──────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: List.generate(4, (i) => const Padding(
                padding: EdgeInsets.only(right: 8),
                child: _ShimmerBox(
                  height: 34,
                  width:  70,
                  radius: 20,
                ),
              )),
            ),
          ),
          const SizedBox(height: 8),

          // ── Vehicle tiles ─────────────────────
          ...List.generate(8, (_) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical:   5,
            ),
            child: _shimmerVehicleTile(context),
          )),
        ],
      ),
    );
  }

  Widget _shimmerVehicleTile(BuildContext context) {
    return Container(
      height:  76,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:        Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // SoH circle
          Container(
            width:  48,
            height: 48,
            decoration: const BoxDecoration(
              color:  Colors.white,
              shape:  BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),

          // Text lines
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Container(
                  height:      14,
                  width:       100,
                  color:       Colors.white,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 11,
                  width:  140,
                  color:  Colors.white,
                ),
              ],
            ),
          ),

          // Badge
          Container(
            width:  60,
            height: 26,
            decoration: BoxDecoration(
              color:        Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// VEHICLE DETAIL SHIMMER
// Matches: SoH circle + 4 section cards
// ═══════════════════════════════════════════════

class VehicleDetailShimmer extends StatelessWidget {
  const VehicleDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _ShimmerWrapper(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            // ── Health Section ───────────────────
            _shimmerSectionCard(
              context: context,
              contentHeight: 180,
            ),

            // ── Trend Section ────────────────────
            _shimmerSectionCard(
              context: context,
              contentHeight: 110,
            ),

            // ── Stress Section ───────────────────
            _shimmerSectionCard(
              context: context,
              contentHeight: 130,
            ),

            // ── Regen Section ────────────────────
            _shimmerSectionCard(
              context: context,
              contentHeight: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerSectionCard({
    required BuildContext context,
    required double contentHeight,
  }) {
    return Container(
      margin:  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:        Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width:  32,
                  height: 32,
                  decoration: BoxDecoration(
                    color:        Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 14,
                  width:  120,
                  color:  Colors.white,
                ),
              ],
            ),
          ),

          // Divider
          Container(height: 1, color: Colors.white.withValues(alpha: 0.4)),

          // Content placeholder
          Container(
            height: contentHeight,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:        Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
