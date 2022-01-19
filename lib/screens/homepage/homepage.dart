import 'package:flutter/material.dart';

import '../../models/video.dart';
import '../../services/api_service.dart';
import 'widgets/video_listtile.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<Video>>(
        future: APIService.instance.fetchVideosFromPlaylist(
          playlistId: 'PLQa-JAExqnKHKa_CyWIJGBtIM7zOCxJix',
        ),
        builder: buildBody,
      ),
    );
  }

  Widget buildBody(context, snapshot) {
    if (snapshot.hasData) {
      List<Video> videos = snapshot.data!;
      return ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          Video video = videos[index];
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
