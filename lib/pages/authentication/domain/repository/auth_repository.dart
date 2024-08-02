import 'package:splitz_bloc/pages/authentication/data/models/user_model.dart';

abstract interface class AuthRepository {
  Future<UserModel> signUp(
      String email, String password, String firstName, String surname);
  Future<UserModel> signInWithGoogle();
  Future<UserModel?> getCurrentUser();
}
