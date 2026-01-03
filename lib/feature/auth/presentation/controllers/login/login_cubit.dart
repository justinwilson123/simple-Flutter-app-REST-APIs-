import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapiproduct/core/classes/save_secure_storage.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/login_use_case.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/profile_use_case.dart';

import '../../../../../core/classes/cach_user.dart';
import '../../../../../core/error/failure.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final ProfileUseCase profile;
  final SaveSecureStorage saveSecureStorage;
  final CachUser cachUser;
  LoginCubit({
    required this.loginUseCase,
    required this.profile,
    required this.saveSecureStorage,
    required this.cachUser,
  }) : super(LoginInitial());

  login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: "", successMessage: ""));
    final result = await loginUseCase(email, password);
    emit(state.copyWith(isLoading: false));
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: _errorMessagre(failure))),
      (userId) {
        cachUser.saveUser(userId);
        getAPiToken();
      },
    );
  }

  getAPiToken() async {
    final response = await profile.call();
    response.fold(
      (failure) {
        emit(state.copyWith(errorMessage: _errorMessagre(failure)));
      },
      (apiKey) async {
        await saveSecureStorage.saveToken(apiKey);
        emit(state.copyWith(successMessage: "Login success"));
      },
    );
  }

  String _errorMessagre(Failure failure) {
    switch (failure) {
      case EmailNotCorrectFailure():
        return "Email Or password is not correct";
      case ServerFailure():
        return "Some thing is wrong pleas try again";
      case OffLineFailure():
        return "No Internet";
      default:
        return "Something went wrong";
    }
  }
}
