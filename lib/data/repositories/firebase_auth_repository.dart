import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';
import '../models/auth_model.dart';

class FirebaseAuthRepository implements AuthRepository {
  final AuthService _authService;

  FirebaseAuthRepository(this._authService);

  @override
  Future<void> signUp(AuthModel authModel) async {
    try {
      // Validate email and password
      if (!_isValidEmail(authModel.email)) {
        throw Exception('Invalid email format');
      }
      if (!_isValidPassword(authModel.password)) {
        throw Exception('Password must be at least 6 characters');
      }

      await _authService.signUpWithEmailAndPassword(authModel);
      // Additional business logic here (e.g., creating user profile)
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> signIn(AuthModel authModel) async {
    try {
      await _authService.signInWithEmailAndPassword(authModel);
      // Additional business logic here (e.g., updating last login)
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
    // Additional cleanup logic
  }

  @override
  Stream<bool> get authStateChanges {
    return _authService.authStateChanges.map((user) => user != null);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _authService.currentUser?.uid;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return Exception('The password provided is too weak.');
      case 'email-already-in-use':
        return Exception('The account already exists for that email.');
      case 'user-not-found':
        return Exception('No user found for that email.');
      case 'wrong-password':
        return Exception('Wrong password provided.');
      default:
        return Exception('Authentication failed: ${e.message}');
    }
  }
}
