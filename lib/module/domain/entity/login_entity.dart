class LoginEntity {
  final String token;

  LoginEntity({
    required this.token,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
