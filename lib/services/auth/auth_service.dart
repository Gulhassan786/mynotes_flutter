//import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/auth/auth_provider.dart';
import 'package:myapp/services/auth/auth_user.dart';
import 'package:myapp/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  @override
  Future<AuthUser> creatUser({
    required String email,
    required String password,
  }) =>
      provider.creatUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();
}
