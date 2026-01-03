part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final String errorMessage;
  final String successMessage;
  final bool isLoading;
  final bool showPass;

  const SignupState({
    this.errorMessage = "",
    this.successMessage = "",
    this.isLoading = false,
    this.showPass = true,
  });

  SignupState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool? showPass,
  }) {
    return SignupState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
    );
  }

  @override
  List<Object> get props => [errorMessage, successMessage, isLoading, showPass];
}

final class SignupInitial extends SignupState {}
