import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository auth;
  LogoutUseCase(this.auth);

  Future<Either<Failure, Unit>> call() async {
    return await auth.logout();
  }
}
