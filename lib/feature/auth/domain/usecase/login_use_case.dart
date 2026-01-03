import 'package:dartz/dartz.dart';
import 'package:restapiproduct/feature/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';

class LoginUseCase {
  final AuthRepository auth;
  LoginUseCase(this.auth);

  Future<Either<Failure, int>> call(String email, String password) async {
    return await auth.login(email, password);
  }
}
