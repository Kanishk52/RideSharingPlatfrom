import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final AuthRepository? _authRepository; // Make nullable

  AuthService({
    FirebaseAuth? firebaseAuth,
    AuthRepository? authRepository, // Make nullable
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _authRepository = authRepository;

  Future<UserCredential> signUpWithEmailAndPassword(AuthModel authModel) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: authModel.email,
      password: authModel.password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword(AuthModel authModel) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: authModel.email,
      password: authModel.password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;
}
