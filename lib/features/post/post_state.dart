import 'package:architecture_demonstration/features/post/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostUninitialized extends PostState {}

class PostError extends PostState {}

class PostLoaded extends PostState {
  final bool hasReachedMax;
  final List<Post> posts;

  const PostLoaded({
    this.hasReachedMax,
    this.posts,
  });

  PostLoaded copyWith({
    bool hasReachedMax,
    List<Post> posts,
  }) {
    return PostLoaded(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [hasReachedMax, posts];

  @override
  String toString() => 'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax';
}
