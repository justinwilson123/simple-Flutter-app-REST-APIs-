import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? repassword;

  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.repassword,
  });

  @override
  List<Object?> get props => [id, name, email, password, repassword];
}
