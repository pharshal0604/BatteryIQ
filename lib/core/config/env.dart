// ignore_for_file: avoid_print

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration manager for EV Fleet Health
/// Provides centralized access to all environment variables
class EnvConfig {
  // Private constructor — prevent instantiation
  EnvConfig._();

  /// Initialize environment — call in main() before runApp()
  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  // ==========================================================================
  // API Configuration
  // ==========================================================================

  /// Base URL for the Spring Boot backend API
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080/api';

  /// API version prefix
  static String get apiVersion => dotenv.env['API_VERSION'] ?? 'v1';

  /// Full API URL with version
  static String get fullApiUrl => '$apiBaseUrl/$apiVersion';

  /// API connect timeout in milliseconds
  static int get connectTimeout =>
      int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '10000') ?? 10000;

  /// API receive timeout in milliseconds
  static int get receiveTimeout =>
      int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '10000') ?? 10000;

  // ==========================================================================
  // App Configuration
  // ==========================================================================

  /// App display name
  static String get appName => dotenv.env['APP_NAME'] ?? 'EV Fleet Health';

  /// App version string
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';

  /// App environment: development / staging / production
  static String get appEnvironment =>
      dotenv.env['APP_ENVIRONMENT'] ?? 'development';

  static bool get isProduction => appEnvironment == 'production';
  static bool get isDevelopment => appEnvironment == 'development';
  static bool get isStaging => appEnvironment == 'staging';

  /// Support contact
  static String get supportEmail =>
      dotenv.env['SUPPORT_EMAIL'] ?? 'fleet@endurance.in';

  // ==========================================================================
  // Polling Configuration
  // ==========================================================================

  /// How often (seconds) the app polls backend for fleet status
  static int get pollIntervalSeconds =>
      int.tryParse(dotenv.env['POLL_INTERVAL_SECONDS'] ?? '30') ?? 30;

  /// SoH threshold (%) below which a vehicle is flagged as Critical
  static double get criticalSoHThreshold =>
      double.tryParse(dotenv.env['CRITICAL_SOH_THRESHOLD'] ?? '70') ?? 70;

  /// SoH threshold (%) below which a vehicle needs Attention
  static double get attentionSoHThreshold =>
      double.tryParse(dotenv.env['ATTENTION_SOH_THRESHOLD'] ?? '85') ?? 85;

  // ==========================================================================
  // Feature Flags
  // ==========================================================================

  /// Show degradation sparkline on vehicle detail
  static bool get isDegradationChartEnabled =>
      _parseBool(dotenv.env['FEATURE_DEGRADATION_CHART'] ?? 'true');

  /// Show regen stats section on vehicle detail
  static bool get isRegenStatsEnabled =>
      _parseBool(dotenv.env['FEATURE_REGEN_STATS'] ?? 'true');

  /// Enable local polling alerts (flutter_local_notifications)
  static bool get isLocalAlertsEnabled =>
      _parseBool(dotenv.env['FEATURE_LOCAL_ALERTS'] ?? 'true');

  /// Show driving stress section on vehicle detail
  static bool get isDrivingStressEnabled =>
      _parseBool(dotenv.env['FEATURE_DRIVING_STRESS'] ?? 'true');
  
  static bool get useMock => _parseBool(dotenv.env['USE_MOCK'] ?? 'true');

  // ==========================================================================
  // Debug & Logging
  // ==========================================================================

  /// Enable debug mode
  static bool get isDebugMode =>
      _parseBool(dotenv.env['DEBUG_MODE'] ?? 'false');

  /// Log level: INFO / DEBUG / ERROR
  static String get logLevel => dotenv.env['LOG_LEVEL'] ?? 'INFO';

  /// Enable Dio network request/response logging
  static bool get isNetworkLogsEnabled =>
      _parseBool(dotenv.env['ENABLE_NETWORK_LOGS'] ?? 'false');

  // ==========================================================================
  // Helper Methods
  // ==========================================================================

  /// Parse boolean from string value
  static bool _parseBool(String value) {
    return value.toLowerCase() == 'true' || value == '1';
  }

  /// Print full config — only runs when DEBUG_MODE=true
  static void printConfig() {
    if (!isDebugMode) return;

    print('=' * 60);
    print('EV Fleet Health — Environment Configuration');
    print('=' * 60);
    print('Environment   : $appEnvironment');
    print('App Version   : $appVersion');
    print('API Base URL  : $apiBaseUrl');
    print('API Version   : $apiVersion');
    print('Full API URL  : $fullApiUrl');
    print('Debug Mode    : $isDebugMode');
    print('Log Level     : $logLevel');
    print('Network Logs  : $isNetworkLogsEnabled');
    print('-' * 60);
    print('Polling:');
    print('  - Interval        : ${pollIntervalSeconds}s');
    print('  - Critical SoH    : <$criticalSoHThreshold%');
    print('  - Attention SoH   : <$attentionSoHThreshold%');
    print('-' * 60);
    print('Feature Flags:');
    print('  - Degradation Chart : $isDegradationChartEnabled');
    print('  - Regen Stats       : $isRegenStatsEnabled');
    print('  - Local Alerts      : $isLocalAlertsEnabled');
    print('  - Driving Stress    : $isDrivingStressEnabled');
    print('=' * 60);
    print('Mock Mode     : $useMock');
    print('=' * 60);
  }
}
