import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restapiproduct/core/error/failure.dart';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/signiup_use_case.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;
  SignupCubit(this.signupUseCase) : super(SignupInitial());

  showPass() {
    emit(state.copyWith(showPass: !state.showPass));
  }

  signup(UserEntity user) async {
    emit(state.copyWith(isLoading: true,errorMessage: "",successMessage: ""));
    final result = await signupUseCase(user);
    emit(state.copyWith(isLoading: false));
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: _errorMessagre(failure))),
      (success) => emit(state.copyWith(successMessage: "User has been created successfully")),
    );
  }

  String _errorMessagre(Failure failure){
    switch (failure) {
      case EmailUseingFailure():
        return "Email has been using";
      case ServerFailure():
      return "Some thing is wrong pleas try again";
       case OffLineFailure():
        return "No Internet";
      default:
        return "Something went wrong";
    }
  }
}
