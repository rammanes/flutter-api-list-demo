import 'dart:convert';

import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  static List<PostModel> listFromJson(String source) {
    final list = jsonDecode(source) as List<dynamic>;
    return list
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
