import 'dart:math';
import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// SOH CIRCLE — animated arc showing battery health
// Used on: Vehicle List tile + Vehicle Detail screen
// Input:   soh (0.0 – 100.0)
// ═══════════════════════════════════════════════

class SoHCircle extends StatefulWidget {
  final double soh; // 0.0 – 100.0
  final double size; // diameter of circle
  final double strokeWidth; // arc thickness
  final bool showLabel; // show 'SoH' label below %
  final bool showStatus; // show 'Good/Monitor/Critical' below
  final bool animate; // animate arc on mount

  const SoHCircle({
    super.key,
    required this.soh,
    this.size = 120,
    this.strokeWidth = 10,
    this.showLabel = true,
    this.showStatus = true,
    this.animate = true,
  });

  @override
  State<SoHCircle> createState() => _SoHCircleState();
}

class _SoHCircleState extends State<SoHCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.soh,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(SoHCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.soh != widget.soh) {
      _animation = Tween<double>(
        begin: oldWidget.soh,
        end: widget.soh,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.fromSoH(widget.soh);
    final status = AppColors.statusFromSoH(widget.soh);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return SizedBox(
          width: widget.size,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Arc + Text ──────────────────────────
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: CustomPaint(
                  painter: _SoHArcPainter(
                    soh: _animation.value,
                    color: color,
                    strokeWidth: widget.strokeWidth,
                    trackColor: Theme.of(context).dividerColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Percentage
                        Text(
                          '${_animation.value.toStringAsFixed(1)}%',
                          style: GoogleFonts.lato(
                            fontSize: widget.size * 0.19,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 1.0,
                          ),
                        ),

                        // SoH label
                        if (widget.showLabel) ...[
                          const SizedBox(height: 2),
                          Text(
                            'SoH',
                            style: GoogleFonts.lato(
                              fontSize: widget.size * 0.10,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).textTheme.bodySmall?.color,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // ── Status Label ─────────────────────────
              if (widget.showStatus) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.lato(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════
// CUSTOM PAINTER — draws the arc
// ═══════════════════════════════════════════════

class _SoHArcPainter extends CustomPainter {
  final double soh; // 0.0 – 100.0
  final Color color;
  final double strokeWidth;
  final Color trackColor;

  _SoHArcPainter({
    required this.soh,
    required this.color,
    required this.strokeWidth,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    // Start from top (-90°), go clockwise
    const startAngle = -pi / 2;
    const fullSweep = 2 * pi;
    final sweepAngle = fullSweep * (soh.clamp(0, 100) / 100);

    // ── Track (background arc) ─────────────────
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      fullSweep,
      false,
      trackPaint,
    );

    // ── Progress arc ───────────────────────────
    if (sweepAngle > 0) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_SoHArcPainter oldDelegate) {
    return oldDelegate.soh != soh ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.trackColor != trackColor;
  }
}

// ═══════════════════════════════════════════════
// SOH CIRCLE SMALL — compact version for list tile
// ═══════════════════════════════════════════════

class SoHCircleSmall extends StatelessWidget {
  final double soh;

  const SoHCircleSmall({super.key, required this.soh});

  @override
  Widget build(BuildContext context) {
    return SoHCircle(
      soh: soh,
      size: 52,
      strokeWidth: 5,
      showLabel: false,
      showStatus: false,
      animate: false, // no animation on list tiles for performance
    );
  }
}

// ═══════════════════════════════════════════════
// SOH CIRCLE LARGE — hero version for detail screen
// ═══════════════════════════════════════════════

class SoHCircleLarge extends StatelessWidget {
  final double soh;

  const SoHCircleLarge({super.key, required this.soh});

  @override
  Widget build(BuildContext context) {
    return SoHCircle(
      soh: soh,
      size: 150,
      strokeWidth: 13,
      showLabel: true,
      showStatus: true,
      animate: true, // full animation on detail screen
    );
  }
}
