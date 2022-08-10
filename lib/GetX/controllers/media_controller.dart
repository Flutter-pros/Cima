import 'package:get/get.dart';

import '../models/movie_api.dart';

class MediaController extends GetxController {
  //* we will make the default state of the myhomepage to show the arabic series
  // FilteredData categoryDataHandler = FilteredData();
  // ApiHandler apiHandler = ApiHandler("");
  List media = [];
  String mediaID = '';
  String mediaTitle = '';
  String mediaDescription = '';
  String mediaImage = '';
  String mediaYear = '';
  String mediaRating = '';
  String mediaDurationInMinutes = '';
  List<String> mediaGenre = [];
  MediaController(
      {required this.mediaID,
      required this.mediaTitle,
      required this.mediaDescription,
      required this.mediaImage,
      required this.mediaYear,
      required this.mediaRating,
      required this.mediaDurationInMinutes,
      required this.mediaGenre});
  var filteredData;
  MediaController.filteredDat({String? taxonamy, String? termID}) {
    if (taxonamy == null && termID == null) {
      filteredData = FilteredData().getData();
    } else {
      if (taxonamy == null) {
        filteredData = filteredData(termID: termID).getData();
      } else {
        if (termID == null) {
          filteredData = filteredData(taxonamy: taxonamy).getData();
        } else {
          filteredData =
              filteredData(taxonamy: taxonamy, termID: termID).getData();
        }
      }
    }

    filteredData.then((value) {
      for (var i = 0; i < value.length; i++) {
        mediaID = value[i]['id'];
        mediaTitle = value[i]['title'];
        mediaDescription = value[i]['description'];
        mediaImage = value[i]['image'];
        mediaYear = value[i]['year'];
        mediaRating = value[i]['rating'];
        mediaDurationInMinutes = value[i]['durationInMinutes'];
        mediaGenre = value[i]['genre'];
        media.add(MediaController(
            mediaID: mediaID,
            mediaTitle: mediaTitle,
            mediaDescription: mediaDescription,
            mediaImage: mediaImage,
            mediaYear: mediaYear,
            mediaRating: mediaRating,
            mediaDurationInMinutes: mediaDurationInMinutes,
            mediaGenre: mediaGenre));
      }
    }); //* the default state of the myhomepage will be the arabic series
    // mediaID = filteredData[0]['id'];
    // mediaTitle = title;
    // mediaDescription = description;
    // mediaImage = image;
    // mediaYear = year;
    // mediaRating = rating;
    // mediaDurationInMinutes = duration;
    // mediaGenre = genre;
    update();
  }
  var searchedData;
  MediaController.searchedData({String? search}) {
    searchedData = (search == null)
        ? SearchData().getData()
        : SearchData(search: search).getData();
    searchedData.then((value) {
      for (var i = 0; i < value.length; i++) {
        mediaID = value[i]['id'];
        mediaTitle = value[i]['title'];
        mediaDescription = value[i]['description'];
        mediaImage = value[i]['image'];
        mediaYear = value[i]['year'];
        mediaRating = value[i]['rating'];
        mediaDurationInMinutes = value[i]['durationInMinutes'];
        mediaGenre = value[i]['genre'];
        media.add(MediaController(
            mediaID: mediaID,
            mediaTitle: mediaTitle,
            mediaDescription: mediaDescription,
            mediaImage: mediaImage,
            mediaYear: mediaYear,
            mediaRating: mediaRating,
            mediaDurationInMinutes: mediaDurationInMinutes,
            mediaGenre: mediaGenre));
      }
    });
    update();
  }
  var relatedPosts;
  MediaController.relatedPosts({String? postID}) {
    relatedPosts = (postID == null)
        ? RelatedPosts().getData()
        : RelatedPosts(postID: postID).getData();
    relatedPosts.then((value) {
      for (var i = 0; i < value.length; i++) {
        mediaID = value[i]['id'];
        mediaTitle = value[i]['title'];
        mediaDescription = value[i]['description'];
        mediaImage = value[i]['image'];
        mediaYear = value[i]['year'];
        mediaRating = value[i]['rating'];
        mediaDurationInMinutes = value[i]['durationInMinutes'];
        mediaGenre = value[i]['genre'];
        media.add(MediaController(
            mediaID: mediaID,
            mediaTitle: mediaTitle,
            mediaDescription: mediaDescription,
            mediaImage: mediaImage,
            mediaYear: mediaYear,
            mediaRating: mediaRating,
            mediaDurationInMinutes: mediaDurationInMinutes,
            mediaGenre: mediaGenre));
      }
    });
    update();
  }
}
