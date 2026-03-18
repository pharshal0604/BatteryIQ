import 'package:ev_fleet_app/core/config/env.dart';
import 'package:ev_fleet_app/features/alerts/models/alert_model.dart';
import 'package:ev_fleet_app/features/alerts/repository/alerts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════
// SEVERITY FILTER PROVIDER
// ═══════════════════════════════════════════════

final alertSeverityFilterProvider = StateProvider<String>((ref) => 'ALL');

// ═══════════════════════════════════════════════
// ALERTS PROVIDER
// Reacts to severity filter changes
// ═══════════════════════════════════════════════

final alertsProvider =
    AsyncNotifierProvider<AlertsNotifier, List<AlertModel>>(
  AlertsNotifier.new,
);

class AlertsNotifier extends AsyncNotifier<List<AlertModel>> {
  @override
  Future<List<AlertModel>> build() async {
    final severity = ref.watch(alertSeverityFilterProvider);
    return _fetch(severity: severity);
  }

  Future<List<AlertModel>> _fetch({required String severity}) async {
    final repo = ref.read(alertsRepositoryProvider);
    return EnvConfig.useMock
        ? repo.getFleetAlertsMock(severity: severity)
        : repo.getFleetAlerts(severity: severity);
  }

  Future<void> refresh() async {
    final severity = ref.read(alertSeverityFilterProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(severity: severity));
  }
}

// ═══════════════════════════════════════════════
// UNREAD COUNT PROVIDER
// Used for badge on notification bell in AppBar
// ═══════════════════════════════════════════════

final criticalAlertCountProvider = Provider<int>((ref) {
  final alertsAsync = ref.watch(alertsProvider);
  return alertsAsync.when(
    data:    (list) => list.where((a) => a.isCritical).length,
    loading: () => 0,
    error:   (_, __) => 0,
  );
});