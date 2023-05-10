class LoginBody {
  final String email;
  final String password;

  LoginBody({
    required this.email,
    required this.password,
  });

  factory LoginBody.fromJson(Map<String, dynamic> json) => LoginBody(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
