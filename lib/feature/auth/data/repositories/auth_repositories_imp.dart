import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/classes/network_info.dart';
import 'package:restapiproduct/core/error/exception.dart';

import 'package:restapiproduct/core/error/failure.dart';

import 'package:restapiproduct/feature/auth/domain/entity/user_entity.dart';

import '../../../../core/classes/cach_user.dart';
import '../../../../core/classes/save_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data/auth_data.dart';
import '../models/user_model.dart';

class AuthRepositoriesImp implements AuthRepository {
  final RemoteDataSourceAuth remoteDataSourceAuth;
  final NetworkInfo networkInfo;
  final SaveSecureStorage saveSecureStorage;
  final CachUser cachUser;

  AuthRepositoriesImp({
    required this.remoteDataSourceAuth,
    required this.networkInfo,
    required this.saveSecureStorage,
    required this.cachUser,
  });

  @override
  Future<Either<Failure, Unit>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSourceAuth.login(email, password);
        await saveSecureStorage.saveToken(user["api_key"]);
        await cachUser.saveUser(user['userId']);
        return Right(unit);
      } on EmailNotCorrectException {
        return Left(EmailNotCorrectFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.logout();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> profile() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSourceAuth.profile();
        return Right(response);
      } on SomethingNotCorrectExeption {
        return Left(SomethingNotCorrectFailure());
      } on ServerFailure {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sginup(UserEntity user) async {
    final userModel = UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
      repassword: user.repassword,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSourceAuth.sginup(userModel);
        return Right(unit);
      } on EmailUseingException {
        return Left(EmailUseingFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
