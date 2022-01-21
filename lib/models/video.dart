import 'package:googleapis/youtube/v3.dart';

class MyVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String description;

  MyVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.description,
  });

  factory MyVideo.fromMap(PlaylistItemSnippet snippet) {
    return MyVideo(
      id: snippet.resourceId!.videoId!,
      title: snippet.title!,
      thumbnailUrl: snippet.thumbnails!.high!.url!,
      channelTitle: snippet.channelTitle!,
      description: snippet.description!,
    );
  }
}
