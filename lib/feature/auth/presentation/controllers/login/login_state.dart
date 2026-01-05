part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String successMessage;
  final String errorMessage;
  final bool isLoading;
  final bool showPass;
  final bool isLogin;

  const LoginState({
    this.errorMessage = "",
    this.successMessage = "",
    this.isLoading = false,
    this.showPass = true,
    this.isLogin = false,
  });

  LoginState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool? showPass,
    bool? isLogin,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  @override
  List<Object> get props => [
    errorMessage,
    successMessage,
    isLoading,
    showPass,
    isLoading,
    isLogin,
  ];
}

final class LoginInitial extends LoginState {}
