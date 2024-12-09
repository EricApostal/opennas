import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:opennas/features/authentication/presentation/screens/login.dart';
import 'package:opennas/features/authentication/presentation/widgets/authentication_shell.dart';
import 'package:opennas/features/authentication/providers/authentication.dart';
import 'package:opennas/features/dashboard/views/dashboard.dart';
import 'package:opennas/features/router/presentation/screens/not_found.dart';
import 'package:opennas/features/services/presentation/screens/services.dart';
import 'package:opennas/features/services/presentation/screens/services_details.dart';
import 'package:opennas/features/storage/views/storage.dart';
import 'package:opennas/features/storage/views/storage_pools.dart';
import 'package:opennas/features/system/views/system.dart';
import 'package:opennas/features/system/views/system_info.dart';
import 'package:opennas/features/system/views/system_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authenticationProvider);
  return GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => const NotFoundScreen(),
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final location = state.fullPath;
      if (!isAuthenticated && location != '/login') {
        return '/login';
      }
      if (isAuthenticated && location == '/login') {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AuthenticatedShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
            routes: [
              // System routes
              GoRoute(
                path: 'system',
                builder: (context, state) => const SystemScreen(),
                routes: [
                  GoRoute(
                    path: 'info',
                    builder: (context, state) => const SystemInfoScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SystemSettingsScreen(),
                  ),
                ],
              ),
              // Storage routes
              GoRoute(
                path: 'storage',
                builder: (context, state) => const StorageScreen(),
                routes: [
                  GoRoute(
                    path: 'pools',
                    builder: (context, state) => const StoragePoolsScreen(),
                  ),
                ],
              ),
              // Services routes
              GoRoute(
                path: 'services',
                builder: (context, state) => const ServicesScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => ServicesDetailsScreen(
                      serviceId: state.pathParameters['id']!,
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
}
