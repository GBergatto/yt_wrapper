import 'package:flutter/material.dart';

import 'package:googleapis/youtube/v3.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import '../../models/video.dart';
import 'widgets/video_listtile.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '[YOUR_OAUTH_2_CLIENT_ID]',
  scopes: [
    'https://www.googleapis.com/auth/youtube', // Youtube scope
  ],
);

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<List<MyVideo>> _getVideos() async {
    // // final GoogleSignInAccount? googleSignInAccount =
    // //     await _googleSignIn.signIn();
    // // final GoogleSignInAuthentication googleSignInAuthentication =
    // //     await googleSignInAccount!.authentication;

    var httpClient = (await _googleSignIn.authenticatedClient())!;
    var youTubeApi = YouTubeApi(httpClient);
    var favorites = await youTubeApi.playlistItems.list(
      ['snippet'],
      playlistId: 'PLQa-JAExqnKHKa_CyWIJGBtIM7zOCxJix',
    );

    List<MyVideo> videos = [];
    for (PlaylistItem item in favorites.items!) {
      videos.add(
        MyVideo.fromMap(item.snippet!),
      );
    }

    return videos;

    // youTubeApi.videos.rate('U7Ef_GFEnLQ', 'like');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<MyVideo>>(
        future: _getVideos(),
        builder: buildBody,
      ),
    );
  }

  Widget buildBody(context, snapshot) {
    if (snapshot.hasData) {
      List<MyVideo> videos = snapshot.data!;
      return ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          MyVideo video = videos[index];
          return VideoListTile(video: video);
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
