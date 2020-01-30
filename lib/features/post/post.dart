import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final String body;
  final int id;
  final String title;

  const Post({
    this.body,
    this.id,
    this.title,
  });

  @override
  List<Object> get props => [body, id, title];

  @override
  String toString() => 'Post { id: $id }';

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
