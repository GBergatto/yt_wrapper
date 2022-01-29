import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '[YOUR_OAUTH_2_CLIENT_ID]',
  scopes: [
    'https://www.googleapis.com/auth/youtube', // Youtube scope
  ],
);

class LikeButton extends StatefulWidget {
  const LikeButton({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  final String videoId;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (_isLiked)
          ? const Icon(Icons.thumb_up_alt)
          : const Icon(Icons.thumb_up_alt_outlined),
      onPressed: () async {
        // TODO: better handle sign in
        final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        var httpClient = (await _googleSignIn.authenticatedClient())!;
        var youTubeApi = YouTubeApi(httpClient);

        if (_isLiked) {
          youTubeApi.videos.rate(widget.videoId, 'none');
        } else {
          youTubeApi.videos.rate(widget.videoId, 'like');
        }

        setState(() {
          _isLiked = !_isLiked;
        });
      },
    );
  }
}
