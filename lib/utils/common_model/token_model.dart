class TokenModel {
  TokenModel({
    this.access,
    this.refresh,
  });

  final String? access;
  final String? refresh;

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      access: json["access"] ?? "",
      refresh: json["refresh"] ?? "",
    );
  }
}
