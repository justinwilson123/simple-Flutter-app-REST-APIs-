part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final String errorMessage;
  final String successMessage;
  final bool isLoading;
  final bool showPass;
  final bool showRepass;

  const SignupState({
    this.errorMessage = "",
    this.successMessage = "",
    this.isLoading = false,
    this.showPass = true,
    this.showRepass = true,
  });

  SignupState copyWith({
    String? errorMessage,
    String? successMessage,
    bool? isLoading,
    bool? showPass,
    bool? showRepass,
  }) {
    return SignupState(
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
      showRepass: showRepass ?? this.showRepass,
    );
  }

  @override
  List<Object> get props => [
    errorMessage,
    successMessage,
    isLoading,
    showPass,
    showRepass,
  ];
}

final class SignupInitial extends SignupState {}
