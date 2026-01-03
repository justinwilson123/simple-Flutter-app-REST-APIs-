import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/auth/domain/repositories/auth_repository.dart';

class ProfileUseCase {
  final AuthRepository auth;
  ProfileUseCase(this.auth);

  Future<Either<Failure, String>> call() async {
    return await auth.profile();
  }
}
