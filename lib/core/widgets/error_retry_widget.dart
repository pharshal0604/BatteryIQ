import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// ERROR RETRY WIDGET — shown when API call fails
// Used on: all 3 screens on AsyncError state
// Variants: full page, inline card, compact
// ═══════════════════════════════════════════════

class ErrorRetryWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final ErrorSize size;
  final IconData? icon;

  const ErrorRetryWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.size = ErrorSize.full,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return switch (size) {
      ErrorSize.full    => _FullPageError(
          message: message,
          onRetry: onRetry,
          icon:    icon ?? Icons.cloud_off_rounded,
        ),
      ErrorSize.card    => _CardError(
          message: message,
          onRetry: onRetry,
          icon:    icon ?? Icons.cloud_off_rounded,
        ),
      ErrorSize.compact => _CompactError(
          message: message,
          onRetry: onRetry,
        ),
    };
  }
}

// ═══════════════════════════════════════════════
// ERROR SIZE ENUM
// ═══════════════════════════════════════════════

enum ErrorSize { full, card, compact }

// ═══════════════════════════════════════════════
// FULL PAGE ERROR — used on whole screen failure
// ═══════════════════════════════════════════════

class _FullPageError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  const _FullPageError({
    required this.message,
    required this.onRetry,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon ────────────────────────────
            Container(
              width:  80,
              height: 80,
              decoration: BoxDecoration(
                color:        AppColors.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                size:  38,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 20),

            // ── Title ───────────────────────────
            Text(
              'Something went wrong',
              style: GoogleFonts.lato(
                fontSize:   18,
                fontWeight: FontWeight.bold,
                color:      Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // ── Message ─────────────────────────
            Text(
              message,
              style: GoogleFonts.lato(
                fontSize: 14,
                height:   1.5,
                color:    Theme.of(context).textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // ── Retry Button ────────────────────
            SizedBox(
              width: 180,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon:  const Icon(Icons.refresh_rounded, size: 18),
                label: Text(
                  'Try Again',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// CARD ERROR — used inside a section card
// ═══════════════════════════════════════════════

class _CardError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  const _CardError({
    required this.message,
    required this.onRetry,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:        Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 36, color: AppColors.error),
          const SizedBox(height: 12),
          Text(
            message,
            style: GoogleFonts.lato(
              fontSize:  13,
              height:    1.5,
              color:     Theme.of(context).textTheme.bodySmall?.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon:  const Icon(Icons.refresh_rounded, size: 16),
            label: Text(
              'Retry',
              style: GoogleFonts.lato(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// COMPACT ERROR — used inline in list / tile
// ═══════════════════════════════════════════════

class _CompactError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CompactError({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icon
          const Icon(
            Icons.error_outline_rounded,
            size:  20,
            color: AppColors.error,
          ),
          const SizedBox(width: 10),

          // Message
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.lato(
                fontSize: 13,
                color:    Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),

          // Retry
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              padding:       const EdgeInsets.symmetric(horizontal: 12),
              minimumSize:   Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.lato(
                fontSize:   13,
                fontWeight: FontWeight.w600,
                color:      AppColors.brandGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRESET ERROR WIDGETS — screen-specific
// ═══════════════════════════════════════════════

/// Full page — network/server down
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ErrorRetryWidget(
      message: 'Cannot reach the server.\nCheck your connection or make sure the backend is running.',
      onRetry: onRetry,
      size:    ErrorSize.full,
      icon:    Icons.wifi_off_rounded,
    );
  }
}

/// Full page — fleet data failed
class FleetLoadErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const FleetLoadErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ErrorRetryWidget(
      message: 'Failed to load fleet data.\nPull down to refresh or tap retry.',
      onRetry: onRetry,
      size:    ErrorSize.full,
      icon:    Icons.directions_car_outlined,
    );
  }
}

/// Full page — vehicle detail failed
class VehicleDetailErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const VehicleDetailErrorWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ErrorRetryWidget(
      message: 'Failed to load vehicle data.\nTap retry to try again.',
      onRetry: onRetry,
      size:    ErrorSize.full,
      icon:    Icons.electric_car_outlined,
    );
  }
}
