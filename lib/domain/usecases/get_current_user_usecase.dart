import 'package:splitz_bloc/domain/entities/user.dart';
import 'package:splitz_bloc/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  Future<User?> call() async {
    final userModel = await authRepository.getCurrentUser();
    if (userModel != null) {
      return User(
        id: userModel.id,
        email: userModel.email,
        firstName: userModel.firstName,
        surname: userModel.surname,
      );
    }
    return null;
  }
}
