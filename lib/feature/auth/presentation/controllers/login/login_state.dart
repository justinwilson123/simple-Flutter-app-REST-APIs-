part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String successMessage;
  final String errorMessage;
  final bool isLoading;
  final bool showPass;

  const LoginState({
    this.errorMessage = "",
    this.successMessage = "",
    this.isLoading = false,
    this.showPass = true,
  });

  LoginState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool? showPass,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
    );
  }

  @override
  List<Object> get props => [errorMessage, successMessage, isLoading, showPass];
}

final class LoginInitial extends LoginState {}
