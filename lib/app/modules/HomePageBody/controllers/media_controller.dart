import 'package:get/get.dart';

import 'package:cima/app/data/movie_api.dart';

class MediaControllerData {
  late String mediaID;
  late String mediaTitle;
  late String mediaDescription;
  late String mediaImage;
  late String mediaYear;
  late String mediaRating;
  late String mediaDurationInMinutes;
  late String mediaGenre;
  late List mediaWatchURL;
  late List mediaDownloads;
  MediaControllerData({
    required this.mediaID,
    required this.mediaTitle,
    required this.mediaImage,
    required this.mediaYear,
  }) {
    MediaData(mediaID: mediaID).getData().then((data) {
      mediaDescription = data[0]["story"];
      mediaRating = data[0]["imdbRating"];
      mediaDurationInMinutes = data[0]["runtime"];
      mediaGenre = data[0]["genre"];
      mediaWatchURL = data[0]["watch___url"];
      mediaDownloads = data[0]["downloads"];
    });
  }
}

class MediaController extends GetxController {
  //* we will make the default state of the myhomepage to show the arabic series

  RxList media = [].obs;

  void filterData({String? taxonamy, String? termID}) async {
    List filteredData = [];
    List locatedMedia = [];

    if (taxonamy == null && termID == null) {
      await FilteredData()
          .getData()
          .then((value) => filteredData.addAll(value));
    } else {
      if (taxonamy == null) {
        await FilteredData(termID: termID!)
            .getData()
            .then((value) => filteredData.addAll(value));
      } else {
        if (termID == null) {
          await FilteredData(taxonamy: taxonamy)
              .getData()
              .then((value) => filteredData.addAll(value));
        } else {
          await FilteredData(taxonamy: taxonamy, termID: termID)
              .getData()
              .then((value) => filteredData.addAll(value));
        }
      }
    }

    for (var data in filteredData) {
      locatedMedia.add(MediaControllerData(
        mediaID: data['termID'],
        mediaTitle: data['title'],
        // mediaDescription: data['story'],
        mediaImage: data['thumbnailUrl'],
        mediaYear: data['year'],
        // mediaRating: data['imdbRating'],
        // mediaDurationInMinutes: data['runtime'],
        // mediaGenre: data['genre'],
        // mediaWatchURL: data['watchURL'],
        // mediaDownloads: data['downloads']
      ));
    }
    media.addAll(locatedMedia);
  }

  void searchData({String? search}) async {
    List searchedData = [];
    List locatedMedia = [];

    if (search == null) {
      await SearchData().getData().then((value) => searchedData.addAll(value));
    } else {
      await SearchData(search: search)
          .getData()
          .then((value) => searchedData.addAll(value));
    }
    for (var data in searchedData) {
      locatedMedia.add(MediaControllerData(
        mediaID: data['termID'],
        mediaTitle: data['title'],
        mediaImage: data['thumbnailUrl'],
        mediaYear: data['year'],
      ));
    }
    media.addAll(locatedMedia);
  }

  void setRelatedPosts({String? postID}) async {
    List relatedPosts = [];
    List locatedMedia = [];

    if (postID == null) {
      await RelatedPosts()
          .getData()
          .then((value) => relatedPosts.addAll(value));
    } else {
      await RelatedPosts(postID: postID)
          .getData()
          .then((value) => relatedPosts.addAll(value));
    }
    for (var post in relatedPosts) {
      locatedMedia.add(MediaControllerData(
        mediaID: post['termID'],
        mediaTitle: post['title'],
        mediaImage: post['thumbnailUrl'],
        mediaYear: post['year'],
      ));
    }
    media.addAll(locatedMedia);
  }
}
