import 'package:ev_fleet_app/features/settings/presentation/settings_screen.dart';
import 'package:ev_fleet_app/screens/fleet_dashboard_screen.dart';
import 'package:ev_fleet_app/screens/vehicle_detail_screen.dart';
import 'package:ev_fleet_app/screens/vehicle_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// GoRouter instance exposed as a Riverpod provider
/// Consumed in main.dart via ref.watch(appRouterProvider)
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    debugLogDiagnostics: true, // disable in production
    routes: _routes,
    errorBuilder: _errorPage,
  );
});

// ==========================================================================
// Route Paths — never use raw strings anywhere in the app
// ==========================================================================

class AppRoutes {
  AppRoutes._();

  static const String dashboard = '/';
  static const String vehicleList = '/vehicles';
  static const String vehicleDetail = '/vehicle/:id';

  /// Build vehicle detail path with actual id
  static String vehicleDetailPath(String id) => '/vehicle/$id';
}

// ==========================================================================
// Route Names — use for goNamed() navigation
// ==========================================================================

class AppRouteNames {
  AppRouteNames._();

  static const String dashboard = 'dashboard';
  static const String vehicleList = 'vehicleList';
  static const String vehicleDetail = 'vehicleDetail';
}

// ==========================================================================
// Route Definitions
// ==========================================================================

final List<RouteBase> _routes = [
  // ── Fleet Dashboard ───────────────────────────────────
  GoRoute(
    path: AppRoutes.dashboard,
    name: AppRouteNames.dashboard,
    builder: (context, state) => const FleetDashboardScreen(),
  ),
  GoRoute(
    path: '/settings',
    name: 'settings',
    builder: (context, state) => const SettingsScreen(),
  ),

  // ── Vehicle List ──────────────────────────────────────
  // Accepts optional query params:
  //   ?filter=ALL|HEALTHY|ATTENTION|CRITICAL
  //   ?stress=ALL|LOW|MEDIUM|HIGH
  //   ?search=VH-001
  GoRoute(
    path: AppRoutes.vehicleList,
    name: AppRouteNames.vehicleList,
    builder: (context, state) {
      final filter = state.uri.queryParameters['filter'] ?? 'ALL';
      final stress = state.uri.queryParameters['stress'] ?? 'ALL';
      final search = state.uri.queryParameters['search'] ?? '';
      return VehicleListScreen(
        initialFilter: filter,
        initialStress: stress,
        initialSearch: search,
      );
    },
  ),

  // ── Vehicle Detail ────────────────────────────────────
  // Path param: id → vehicleId
  GoRoute(
    path: AppRoutes.vehicleDetail,
    name: AppRouteNames.vehicleDetail,
    builder: (context, state) {
      final vehicleId = state.pathParameters['id'] ?? '';
      return VehicleDetailScreen(vehicleId: vehicleId);
    },
  ),
];

// ==========================================================================
// Error Page
// ==========================================================================

Widget _errorPage(BuildContext context, GoRouterState state) {
  return Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Route not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            state.uri.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.dashboard),
            icon: const Icon(Icons.home_rounded),
            label: const Text('Go to Dashboard'),
          ),
        ],
      ),
    ),
  );
}

// ==========================================================================
// Navigation Extensions — call from any widget with context
// ==========================================================================

extension AppNavigation on BuildContext {
  // ── Go (replace current) ──────────────────────────────

  void goToDashboard() => go(AppRoutes.dashboard);

  void goToVehicleList({
    String filter = 'ALL',
    String stress = 'ALL',
    String search = '',
  }) =>
      go(
        AppRoutes.vehicleList,
        extra: {
          'filter': filter,
          'stress': stress,
          'search': search,
        },
      );

  void goToVehicleDetail(String vehicleId) =>
      go(AppRoutes.vehicleDetailPath(vehicleId));

  // ── Push (stack on top) ───────────────────────────────

  void pushVehicleDetail(String vehicleId) =>
      push(AppRoutes.vehicleDetailPath(vehicleId));

  void pushVehicleList({
    String filter = 'ALL',
    String stress = 'ALL',
    String search = '',
  }) =>
      push(
        Uri(
          path: AppRoutes.vehicleList,
          queryParameters: {
            'filter': filter,
            'stress': stress,
            if (search.isNotEmpty) 'search': search,
          },
        ).toString(),
      );
}
