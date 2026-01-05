import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapiproduct/feature/auth/domain/usecase/login_use_case.dart';

import '../../../../../core/classes/cach_user.dart';
import '../../../../../core/error/failure.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final CachUser cachUser;
  LoginCubit({required this.loginUseCase, required this.cachUser})
    : super(LoginInitial());

  login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: "", successMessage: ""));
    final result = await loginUseCase(email, password);
    emit(state.copyWith(isLoading: false));
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: _errorMessagre(failure))),
      (_) {
        emit(state.copyWith(successMessage: "Login success"));
      },
    );
  }

  showHidePassword() {
    emit(state.copyWith(showPass: !state.showPass, errorMessage: ""));
  }

  getIsLogin() async {
    final isLogin = await cachUser.getUserId();
    if (isLogin == 0) {
      emit(state.copyWith(isLogin: false));
    } else {
      emit(state.copyWith(isLogin: true));
    }
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
