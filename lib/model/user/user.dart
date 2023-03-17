class UserModel {
  UserModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int? userId;
  int? id;
  String? title;
  bool? completed;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );
}
