import '../../data/models/auth_model.dart';

abstract class AuthRepository {
  Future<void> signUp(AuthModel authModel);
  Future<void> signIn(AuthModel authModel);
  Future<void> signOut();
  Stream<bool> get authStateChanges;
  Future<String?> getCurrentUserId();
}
