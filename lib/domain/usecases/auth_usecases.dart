import '../repositories/auth_repository.dart';
import '../../data/models/auth_model.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<void> call(AuthModel authModel) async {
    await _authRepository.signUp(authModel);
  }
}

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<void> call(AuthModel authModel) async {
    await _authRepository.signIn(authModel);
  }
}

class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  Future<void> call() async {
    await _authRepository.signOut();
  }
}

class GetAuthStateUseCase {
  final AuthRepository _authRepository;

  GetAuthStateUseCase(this._authRepository);

  Stream<bool> call() {
    return _authRepository.authStateChanges;
  }
}
