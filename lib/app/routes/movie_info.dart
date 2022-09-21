// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cima/app/components/movie_info_future_builder.dart';
import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/modules/HomePageBody/controllers/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cima/app/library/globals.dart' as globals;

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({Key? key, required this.arguments}) : super(key: key);
  final MediaControllerData arguments;
  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  // final MediaControllerData argument = Get.arguments as MediaControllerData;
  final MediaController mediaController = Get.put(MediaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: (globals.isSeries)
                ? SeriesEpisods(seriesID: widget.arguments.mediaID).getData()
                : MediaData(mediaID: widget.arguments.mediaID).getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieInfoFutureBuilder(
                    snapshotData: (globals.isSeries)
                        ? snapshot.data as List
                        : snapshot.data as Map<String, dynamic>,
                    arguments: widget.arguments);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
