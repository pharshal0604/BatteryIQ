import 'package:ev_fleet_app/core/config/env.dart';
import 'package:ev_fleet_app/core/router/app_router.dart';
import 'package:ev_fleet_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.initialize();       // ← loads .env first
  EnvConfig.printConfig();            // ← prints only if DEBUG_MODE=true
  runApp(const ProviderScope(child: EvFleetApp()));
}

class EvFleetApp extends ConsumerWidget {
  const EvFleetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: EnvConfig.appName,
      themeMode:  ThemeMode.system,
      theme:      AppTheme.lightTheme,
      darkTheme:  AppTheme.darkTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: EnvConfig.isDevelopment,
    );
  }
}
