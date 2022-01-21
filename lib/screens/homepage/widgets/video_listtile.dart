import 'package:flutter/material.dart';

import '../../../models/video.dart';
import '../../video_page/video_page.dart';

class VideoListTile extends StatelessWidget {
  const VideoListTile({
    Key? key,
    required this.video,
  }) : super(key: key);

  final MyVideo video;

  void openVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPage(
          videoId: video.id,
          title: video.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () => openVideo(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              width: width,
              height: width * 9 / 16,
              image: NetworkImage(video.thumbnailUrl),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
              child: Text(
                video.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
