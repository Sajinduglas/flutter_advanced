import 'dart:convert';

class DataModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  DataModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory DataModel.fromRawJson(String str) => DataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
