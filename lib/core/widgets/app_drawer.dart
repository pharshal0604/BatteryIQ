import 'package:ev_fleet_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════
// DRAWER ITEM MODEL — pass anywhere
// ═══════════════════════════════════════════════

class DrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;
  final bool isSelected;
  final bool isDividerBefore;

  const DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.iconColor,
    this.textColor,
    this.isSelected = false,
    this.isDividerBefore = false,
  });
}

// ═══════════════════════════════════════════════
// DRAWER BADGE
// ═══════════════════════════════════════════════

class DrawerBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const DrawerBadge(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.brandGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.lato(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: c,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// MAIN APP DRAWER
// ═══════════════════════════════════════════════

class AppDrawer extends StatelessWidget {
  final String appName;
  final String appSubtitle;
  final IconData appIcon;
  final String? roleBadgeLabel;
  final List<DrawerItem> items;
  final Widget? footer;
  final String? versionLabel;

  const AppDrawer({
    super.key,
    this.appName = 'EV Fleet Health',
    this.appSubtitle = 'Endurance Technologies',
    this.appIcon = Icons.electric_bolt_rounded,
    this.roleBadgeLabel,
    required this.items,
    this.footer,
    this.versionLabel = 'v1.0.0',
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _DrawerHeader(
            appName: appName,
            appSubtitle: appSubtitle,
            appIcon: appIcon,
            roleBadgeLabel: roleBadgeLabel,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: items.map((item) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.isDividerBefore)
                      const Divider(height: 32, indent: 20, endIndent: 20),
                    _DrawerTile(item: item),
                  ],
                );
              }).toList(),
            ),
          ),
          footer ?? _DrawerFooter(versionLabel: versionLabel ?? 'v1.0.0'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRIVATE: HEADER
// ═══════════════════════════════════════════════

class _DrawerHeader extends StatelessWidget {
  final String appName;
  final String appSubtitle;
  final IconData appIcon;
  final String? roleBadgeLabel;

  const _DrawerHeader({
    required this.appName,
    required this.appSubtitle,
    required this.appIcon,
    this.roleBadgeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 24, left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.brandGreen,
            AppColors.brandGreen.withValues(alpha: 0.75),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(appIcon, size: 36, color: Colors.white),
          ),
          const SizedBox(height: 16),

          // App Name
          Text(
            appName,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            appSubtitle,
            style: GoogleFonts.lato(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),

          // Role Badge — only shown if provided
          if (roleBadgeLabel != null) ...[
            const SizedBox(height: 14),
            Material(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      roleBadgeLabel!,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRIVATE: TILE
// ═══════════════════════════════════════════════

class _DrawerTile extends StatelessWidget {
  final DrawerItem item;
  const _DrawerTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: item.isSelected
            ? AppColors.brandGreen.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          size: 22,
          color: item.isSelected
              ? AppColors.brandGreen
              : (item.iconColor ?? Theme.of(context).colorScheme.onSurface),
        ),
        title: Text(
          item.title,
          style: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: item.isSelected ? FontWeight.w600 : FontWeight.w500,
            color: item.isSelected
                ? AppColors.brandGreen
                : (item.textColor ?? Theme.of(context).colorScheme.onSurface),
          ),
        ),
        trailing: item.trailing,
        onTap: () {
          // Close drawer first using root navigator, then fire the item's onTap
          Navigator.of(context).pop();
          item.onTap();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        minVerticalPadding: 8,
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// PRIVATE: FOOTER
// ═══════════════════════════════════════════════

class _DrawerFooter extends StatelessWidget {
  final String versionLabel;
  const _DrawerFooter({required this.versionLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.verified_outlined,
            size: 15,
            color: AppColors.brandGreen,
          ),
          const SizedBox(width: 8),
          Text(
            'EV Fleet Health  •  $versionLabel',
            style: GoogleFonts.lato(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════
// SHARED DIALOGS — call from anywhere
// ═══════════════════════════════════════════════

class AppDrawerDialogs {
  AppDrawerDialogs._();

  static void showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: _dialogTitle(
          context,
          icon: Icons.help_outline,
          label: 'Help & Support',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _helpItem(context,
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'fleet@endurance.in'),
            const SizedBox(height: 12),
            _helpItem(context,
                icon: Icons.chat_outlined,
                title: 'Live Chat',
                subtitle: 'Available 9AM – 6PM IST'),
            const SizedBox(height: 12),
            _helpItem(context,
                icon: Icons.book_outlined,
                title: 'Documentation',
                subtitle: 'docs.endurance-fleet.in'),
          ],
        ),
        actions: [_closeButton(context, ctx)],
      ),
    );
  }

  static void showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: _dialogTitle(
          context,
          icon: Icons.info_outline,
          label: 'About',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.brandGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.electric_bolt_rounded,
                size: 40,
                color: AppColors.brandGreen,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'EV Fleet Health',
              style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Version 1.0.0',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Real-time battery health monitoring for Endurance EV fleets. Track SoH, RUL, driving stress and regeneration data.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 13,
                height: 1.6,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              '© 2026 Endurance Technologies. All rights reserved.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 11,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
        actions: [_closeButton(context, ctx)],
      ),
    );
  }

  // ── Private helpers ──────────────────────────

  static Widget _dialogTitle(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.brandGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandGreen),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  static Widget _helpItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).iconTheme.color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.lato(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _closeButton(BuildContext context, BuildContext dialogCtx) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogCtx),
      child: Text(
        'Close',
        style: GoogleFonts.lato(
          color: AppColors.brandGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
