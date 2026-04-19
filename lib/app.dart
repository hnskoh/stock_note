import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/sync/providers/sync_provider.dart';

class StockNoteApp extends ConsumerStatefulWidget {
  const StockNoteApp({super.key});

  @override
  ConsumerState<StockNoteApp> createState() => _StockNoteAppState();
}

class _StockNoteAppState extends ConsumerState<StockNoteApp> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();

    // 앱 시작 후 첫 프레임에서 Check-out 시도
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerCheckOut();
    });

    _lifecycleListener = AppLifecycleListener(
      onPause: _triggerCheckIn,
      onDetach: _triggerCheckIn,
    );
  }

  void _triggerCheckOut() {
    final user = ref.read(authStateProvider).valueOrNull;
    if (user != null) {
      ref.read(syncControllerProvider.notifier).performCheckOut();
    }
  }

  Future<void> _triggerCheckIn() async {
    final user = ref.read(authStateProvider).valueOrNull;
    if (user != null) {
      await ref.read(syncControllerProvider.notifier).performCheckIn();
    }
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: '주식 노트',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
