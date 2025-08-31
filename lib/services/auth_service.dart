import 'package:firebase_auth/firebase_auth.dart';
import '../domain/repositories/auth_repository.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final AuthRepository? _authRepository; // Make nullable

  AuthService({
    FirebaseAuth? firebaseAuth,
    AuthRepository? authRepository, // Make nullable
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _authRepository = authRepository;

  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;
}
