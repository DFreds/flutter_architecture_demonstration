import 'package:architecture_demonstration/features/post/post_bloc.dart';
import 'package:architecture_demonstration/features/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/post/post_event.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Architecture Demonstration'),
        ),
        body: BlocProvider(
          create: (context) => PostBloc(httpClient: http.Client())..add(Fetch()),
          child: PostScreen(),
        ),
      ),
      title: 'Architecture Demonstration',
    );
  }
}
