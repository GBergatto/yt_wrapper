import 'package:flutter/material.dart';

import 'screens/homepage/homepage.dart';

// https://github.com/MarcusNg/flutter_youtube_api
// https://youtu.be/feQhHStBVLE
// https://developers.google.com/youtube/v3/docs
// https://github.com/sarbagyastha/youtube_player_flutter/tree/master/packages/youtube_player_flutter

void main() {
  runApp(const MyApp());
}

ThemeData theme = ThemeData.dark();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const Homepage(),
    );
  }
}
