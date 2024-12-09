import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opennas/features/authentication/providers/authentication.dart';
import 'package:opennas/features/router/providers/router.dart';

class RouterListenable extends ChangeNotifier {
  final Ref ref;

  RouterListenable(this.ref) {
    ref.listen(authenticationProvider, (previous, next) {
      // Redirect to login if logged out
      next.whenOrNull(
        initial: () => ref.read(routerProvider).go('/login'),
        authenticated: (_) => ref.read(routerProvider).go('/'),
      );
      notifyListeners();
    });
  }
}
