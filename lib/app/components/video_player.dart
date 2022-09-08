import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String url;
  const VideoPlayer(
      {Key? key,
      this.url =
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'})
      : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController!.initialize().then((_) {
      _chewieController = ChewieController(
          allowFullScreen: true,
          autoPlay: true,
          fullScreenByDefault: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.black,
            bufferedColor: Colors.grey,
          ),
          aspectRatio: 1.2,
          videoPlayerController: _videoPlayerController!);
      setState(() {
        log("video player is good");
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _chewieVideoPlayer());
  }

  Widget _chewieVideoPlayer() {
    return _chewieController != null && _videoPlayerController != null
        ? Container(
            color: Colors.black, child: Chewie(controller: _chewieController!))
        : Container(
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator()));
  }
}
