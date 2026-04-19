import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/trades/screens/trade_list_screen.dart';
import '../../features/trades/screens/trade_form_screen.dart';
import '../../features/trades/screens/trade_detail_screen.dart';
import '../../features/accounts/screens/account_list_screen.dart';
import '../../features/accounts/screens/account_form_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState.valueOrNull != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoggingIn) return '/login';
      if (isAuthenticated && isLoggingIn) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (ctx, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/trades',
            builder: (_, __) => const TradeListScreen(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (_, __) => const TradeFormScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (_, state) => TradeDetailScreen(
                  tradeId: int.parse(state.pathParameters['id']!),
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (_, state) {
                      // ':id'는 상위 경로에서 왔음
                      final segments = state.matchedLocation.split('/');
                      final id = int.tryParse(segments[segments.length - 2]);
                      return TradeFormScreen(tradeId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            builder: (_, __) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'accounts',
                builder: (_, __) => const AccountListScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (_, __) => const AccountFormScreen(),
                  ),
                  GoRoute(
                    path: ':id/edit',
                    builder: (_, state) => AccountFormScreen(
                      accountId:
                          int.tryParse(state.pathParameters['id'] ?? ''),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    int selectedIndex = 0;
    if (location.startsWith('/trades')) selectedIndex = 1;
    if (location.startsWith('/settings')) selectedIndex = 2;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go('/dashboard');
            case 1:
              context.go('/trades');
            case 2:
              context.go('/settings');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: '대시보드',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: '매매 기록',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
