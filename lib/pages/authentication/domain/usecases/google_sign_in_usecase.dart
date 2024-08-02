import 'package:splitz_bloc/pages/authentication/domain/entities/user.dart';
import 'package:splitz_bloc/pages/authentication/domain/repository/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository authRepository;

  GoogleSignInUseCase(this.authRepository);

  Future<User> call() async {
    final userModel = await authRepository.signInWithGoogle();
    return User(
      id: userModel.id,
      email: userModel.email,
      firstName: userModel.firstName,
      surname: userModel.surname,
    );
  }
}
