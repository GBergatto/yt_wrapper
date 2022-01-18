import 'package:flutter/material.dart';
import 'package:yt_wrapper/screens/video_page/video_page.dart';

import '../../models/video.dart';
import '../../services/api_service.dart';

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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Video> videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                Video video = videos[index];
                return ListTile(
                  title: Text(video.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPage(
                          videoId: video.id,
                          title: video.title,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
