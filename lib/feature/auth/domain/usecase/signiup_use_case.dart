import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/auth/domain/entity/user_entity.dart';
import 'package:restapiproduct/feature/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository auth;
  SignupUseCase(this.auth);

  Future<Either<Failure, Unit>> call(UserEntity user) async {
    return await auth.sginup(user);
  }
}
