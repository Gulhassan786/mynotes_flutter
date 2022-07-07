import 'dart:ffi';

import 'package:flutter/rendering.dart';
import 'package:myapp/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<void> initialize();
  
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> creatUser({
    required String email,
    required String password,
  });

  Future<void> logout();
  Future<void> sendEmailVerification();
}
