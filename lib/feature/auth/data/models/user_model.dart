import 'package:restapiproduct/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.name,
    super.email,
    super.password,
    super.repassword,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        repassword: json['repassword'],
      );

      Map<String, dynamic> toJson() => {
            'name': name,
            'email': email,
            'password': password,
            'password_config': repassword,
          };
}