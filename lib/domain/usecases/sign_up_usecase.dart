import 'package:splitz_bloc/domain/entities/user.dart';
import 'package:splitz_bloc/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<User> call(
      String email, String password, String firstName, String surname) async {
    final userModel =
        await authRepository.signUp(email, password, firstName, surname);
    return User(
      id: userModel.id,
      email: userModel.email,
      firstName: userModel.firstName,
      surname: userModel.surname,
    );
  }
}
