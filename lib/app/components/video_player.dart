import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class SamplePlayer extends StatefulWidget {
  SamplePlayer({Key? key, required this.url}) : super(key: key);
  late String url;
  @override
  // ignore: library_private_types_in_public_api
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.url,
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}
