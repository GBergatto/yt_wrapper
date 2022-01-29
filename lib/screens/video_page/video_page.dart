import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yt_wrapper/models/video.dart';

import 'widgets/like_button.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  final MyVideo video;

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        enableCaption: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_isFullScreen)
          ? null
          : AppBar(
              title: Text(widget.video.title),
            ),
      body: YoutubePlayerBuilder(
        onEnterFullScreen: () {
          setState(() {
            _isFullScreen = true;
          });
        },
        onExitFullScreen: () {
          setState(() {
            _isFullScreen = false;
          });
        },
        player: YoutubePlayer(
          controller: _controller,
          onReady: () {
            print('Ready');
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              LikeButton(videoId: widget.video.id),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(widget.video.description),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
