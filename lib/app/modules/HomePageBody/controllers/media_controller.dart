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
    List locatedMedia = [];

    if (taxonamy == null && termID == null) {
      filteredData = FilteredData().getData() as List;
    } else {
      if (taxonamy == null) {
        filteredData = FilteredData(termID: termID!).getData() as List;
      } else {
        if (termID == null) {
          filteredData = FilteredData(taxonamy: taxonamy).getData() as List;
        } else {
          filteredData = FilteredData(taxonamy: taxonamy, termID: termID)
              .getData() as RxList;
        }
      }
    }

    for (var data in filteredData) {
      locatedMedia.add(MediaControllerData(
          mediaID: data['id'],
          mediaTitle: data['title'],
          mediaDescription: data['story'],
          mediaImage: data['image'],
          mediaYear: data['releaseyear'],
          mediaRating: data['imdbRating'],
          mediaDurationInMinutes: data['runtime'],
          mediaGenre: data['genre'],
          mediaWatchURL: data['watchURL'],
          mediaDownloads: data['downloads']));
    }
    media.add(locatedMedia as RxList);
  }

  void searchData({String? search}) {
    List searchedData = [];
    List locatedMedia = [];

    searchedData = (search == null)
        ? SearchData().getData() as List
        : SearchData(search: search).getData() as List;
    for (var data in searchedData) {
      locatedMedia.add(MediaControllerData(
          mediaID: data['id'],
          mediaTitle: data['title'],
          mediaDescription: data['story'],
          mediaImage: data['image'],
          mediaYear: data['releaseyear'],
          mediaRating: data['imdbRating'],
          mediaDurationInMinutes: data['runtime'],
          mediaGenre: data['genre'],
          mediaWatchURL: data['watchURL'],
          mediaDownloads: data['downloads']));
    }
    media.add(locatedMedia as RxList);
  }

  void setRelatedPosts({String? postID}) {
    List relatedPosts = [];
    List locatedMedia = [];

    relatedPosts = (postID == null)
        ? RelatedPosts().getData() as List
        : RelatedPosts(postID: postID).getData() as List;
    for (var post in relatedPosts) {
      locatedMedia.add(MediaControllerData(
          mediaID: post['id'],
          mediaTitle: post['title'],
          mediaDescription: post['story'],
          mediaImage: post['image'],
          mediaYear: post['releaseyear'],
          mediaRating: post['imdbRating'],
          mediaDurationInMinutes: post['runtime'],
          mediaGenre: post['genre'],
          mediaWatchURL: post['watchURL'],
          mediaDownloads: post['downloads']));
    }
    media.add(locatedMedia as RxList);
  }
}
