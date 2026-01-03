import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/error/failure.dart';
import 'package:restapiproduct/feature/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> sginup(UserEntity user);
  Future<Either<Failure, int>> login(String email, String password);
  Future<Either<Failure, String>> profile();
  Future<Either<Failure, Unit>> logout();
}
