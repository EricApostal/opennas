import 'package:opennas/features/authentication/providers/authentication.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_guard.g.dart';

@riverpod
class NavigationGuard extends _$NavigationGuard {
  @override
  FutureOr<bool> build() async {
    final authState = ref.watch(authenticationProvider);

    return authState.maybeWhen(
      authenticated: (_) => true,
      orElse: () => false,
    );
  }
}
