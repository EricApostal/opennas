import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opennas/features/authentication/providers/authentication.dart';
import 'package:opennas/features/router/providers/router.dart';

class AuthenticatedShell extends ConsumerWidget {
  final Widget child;

  const AuthenticatedShell({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authenticationProvider, (previous, next) {
      next.maybeWhen(
        initial: () => ref.read(routerProvider).go('/login'),
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          ref.read(routerProvider).go('/login');
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authenticationProvider.notifier).logout(),
          ),
        ],
      ),
      body: child,
    );
  }
}
