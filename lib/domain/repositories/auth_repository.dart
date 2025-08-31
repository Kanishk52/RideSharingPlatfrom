abstract class AuthRepository {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Stream<bool> get authStateChanges;
  Future<String?> getCurrentUserId();
}
