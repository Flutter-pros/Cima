import 'package:get/get.dart';

import 'package:cima/data/movie_api.dart';

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
  MediaControllerData(
      {required this.mediaID,
      required this.mediaTitle,
      required this.mediaDescription,
      required this.mediaImage,
      required this.mediaYear,
      required this.mediaRating,
      required this.mediaDurationInMinutes,
      required this.mediaGenre,
      required this.mediaWatchURL,
      required this.mediaDownloads});
}

class MediaController extends GetxController {
  //* we will make the default state of the myhomepage to show the arabic series

  RxList media = [].obs;

  void filterData({String? taxonamy, String? termID}) {
    List filteredData = [];

    if (taxonamy == null && termID == null) {
      filteredData = FilteredData().getData() as RxList;
    } else {
      if (taxonamy == null) {
        filteredData = FilteredData(termID: termID!).getData() as RxList;
      } else {
        if (termID == null) {
          filteredData = FilteredData(taxonamy: taxonamy).getData() as RxList;
        } else {
          filteredData = FilteredData(taxonamy: taxonamy, termID: termID)
              .getData() as RxList;
        }
      }
    }

    for (var data in filteredData) {
      for (var i = 0; i < data.length; i++) {
        media.value.add(MediaControllerData(
            mediaID: data[i]['id'],
            mediaTitle: data[i]['title'],
            mediaDescription: data[i]['story'],
            mediaImage: data[i]['image'],
            mediaYear: data[i]['releaseyear'],
            mediaRating: data[i]['imdbRating'],
            mediaDurationInMinutes: data[i]['runtime'],
            mediaGenre: data[i]['genre'],
            mediaWatchURL: data[i]['watchURL'],
            mediaDownloads: data[i]['downloads']));
      }
    }
  }

  void searchData({String? search}) {
    List searchedData = [];
    searchedData = (search == null)
        ? SearchData().getData() as RxList
        : SearchData(search: search).getData() as RxList;
    for (var data in searchedData) {
      for (var i = 0; i < data.length; i++) {
        media.value.add(MediaControllerData(
            mediaID: data[i]['id'],
            mediaTitle: data[i]['title'],
            mediaDescription: data[i]['story'],
            mediaImage: data[i]['image'],
            mediaYear: data[i]['releaseyear'],
            mediaRating: data[i]['imdbRating'],
            mediaDurationInMinutes: data[i]['runtime'],
            mediaGenre: data[i]['genre'],
            mediaWatchURL: data[i]['watchURL'],
            mediaDownloads: data[i]['downloads']));
      }
    }
  }

  void setRelatedPosts({String? postID}) {
    List relatedPosts = [];

    relatedPosts = (postID == null)
        ? RelatedPosts().getData() as RxList
        : RelatedPosts(postID: postID).getData() as RxList;
    for (var post in relatedPosts) {
      for (var i = 0; i < post.length; i++) {
        media.value.add(MediaControllerData(
            mediaID: post[i]['id'],
            mediaTitle: post[i]['title'],
            mediaDescription: post[i]['story'],
            mediaImage: post[i]['image'],
            mediaYear: post[i]['releaseyear'],
            mediaRating: post[i]['imdbRating'],
            mediaDurationInMinutes: post[i]['runtime'],
            mediaGenre: post[i]['genre'],
            mediaWatchURL: post[i]['watchURL'],
            mediaDownloads: post[i]['downloads']));
      }
    }
  }
}
