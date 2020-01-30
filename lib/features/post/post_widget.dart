import 'package:architecture_demonstration/features/post/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      isThreeLine: true,
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10),
      ),
      subtitle: Text(post.body),
      title: Text(post.title),
    );
  }
}
