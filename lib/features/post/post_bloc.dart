import 'dart:convert';

import 'package:architecture_demonstration/features/post/post.dart';
import 'package:architecture_demonstration/features/post/post_event.dart';
import 'package:architecture_demonstration/features/post/post_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(
            hasReachedMax: false,
            posts: posts,
          );
          return;
        }

        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);

          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  hasReachedMax: false,
                  posts: currentState.posts + posts,
                );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  @override
  Stream<PostState> transformEvents(
    Stream<PostEvent> events,
    Stream<PostState> Function(PostEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  bool _hasReachedMax(PostState givenState) => givenState is PostLoaded && givenState.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response =
        await httpClient.get('https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
