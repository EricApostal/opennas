import 'package:opennas/core/exceptions/truenas_exception.dart';
import 'package:opennas/features/authentication/models/auth_state.dart';
import 'package:opennas/features/authentication/repositories/authentication.dart';
import 'package:opennas/features/system/providers/dio_client.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication.g.dart';

@riverpod
class Authentication extends _$Authentication {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> login(String username, String password) async {
    state = const AuthState.authenticating();

    try {
      print("logging in");
      final token = await ref
          .read(authRepositoryProvider)
          .generateToken(username: username, password: password);
      print("got token!");
      state = AuthState.authenticated(token);
    } catch (e) {
      print("Error: ${(e as AuthException).message}");
      state = AuthState.error(e.toString());
    }
  }

  void logout() {
    state = const AuthState.initial();
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRepository(dioClient);
}
