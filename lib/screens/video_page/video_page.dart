import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    Key? key,
    required this.title,
    required this.videoId,
  }) : super(key: key);

  final String title;
  final String videoId;

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
      initialVideoId: widget.videoId,
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
              title: Text(widget.title),
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
            ],
          );
        },
      ),
    );
  }
}
