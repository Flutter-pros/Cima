import 'package:get/get.dart';

import 'package:cima/app/data/movie_api.dart';

class MediaControllerData {
  late String mediaID;
  late String mediaTitle;
  String? mediaDescription;
  late String mediaImage;
  late String mediaYear;
  String? mediaRating;
  String? mediaDurationInMinutes;
  String? mediaGenre;
  String? mediaWatchURL;
  List? mediaDownloads;
  MediaControllerData({
    required this.mediaID,
    required this.mediaTitle,
    required this.mediaImage,
    required this.mediaYear,
  });
  getMoreDetails() async {
    await MediaData(mediaID: mediaID).getData().then((data) {
      mediaDescription = data["story"];
      mediaRating = data["imdbRating"];
      mediaDurationInMinutes = data["runtime"];
      mediaGenre = data["genre"];
      mediaWatchURL = data["watch___url"];
      mediaDownloads = data["downloads"];
    });
  }
}

class MediaController extends GetxController {
  //* we will make the default state of the myhomepage to show the arabic series

  RxList media = [].obs;
  RxBool isSeries = true.obs;
  RxBool isPreviousActivated = false.obs;
  RxBool isFiltersTriggered = false.obs;
  RxInt appliedFilters = 0.obs;
  //! the bellw two methods are used to enable the previous button in the homepage screen to avoid filling the screens stack .
  void goPrevious() {
    if (media.length > 1) {
      media.removeLast();
    } else {
      isPreviousActivated.value = false;
      // media.removeLast();
    }
  }

  void _goNext() {
    if (media.length > 1) {
      isPreviousActivated.value = true;
    }
  }

  void filterData({String? taxonomy, String? termID}) async {
    List filteredData = [];
    List locatedMedia = [];

    if (taxonomy == null && termID == null) {
      await FilteredData()
          .getData()
          .then((value) => filteredData.addAll(value));
    } else {
      if (taxonomy == null) {
        await FilteredData(termID: termID!)
            .getData()
            .then((value) => filteredData.addAll(value));
      } else {
        if (termID == null) {
          await FilteredData(taxonamy: taxonomy)
              .getData()
              .then((value) => filteredData.addAll(value));
        } else {
          await FilteredData(taxonamy: taxonomy, termID: termID)
              .getData()
              .then((value) => filteredData.addAll(value));
        }
      }
    }

    for (var data in filteredData) {
      locatedMedia.add(MediaControllerData(
        mediaID: data['termID'] ?? data["id"],
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
    if (taxonomy != "category") {
      List locatedMediaIDs = locatedMedia.map((e) => e.mediaID).toList();
      if (isFiltersTriggered.value) {
        media.last = media.last
            .where((element) => locatedMediaIDs.contains(element.mediaID))
            .toList();
        appliedFilters.value = appliedFilters.value - 1;
        isFiltersTriggered.value = (appliedFilters.value < 1) ? false : true;
      } else {
        appliedFilters.value = appliedFilters.value + 1;
        locatedMedia = media.last
            .where((element) => locatedMediaIDs.contains(element.mediaID))
            .toList();
        media.insert(media.length, locatedMedia);
        _goNext();
      }
    } else {
      media.insert(media.length, locatedMedia);
      _goNext();
    }
  }

  List<String> getFilters() {
    List<String> filters = [];
    Filters().getData().then((value) {
      value.forEach((element) {
        filters.add(element["taxonomy"]);
      });
    });
    return filters;
  }

  void searchLocalData({String search = ''}) {
    List locatedMedia = [];
    for (var data in media.last) {
      if (data.mediaTitle.toLowerCase().contains(search.toLowerCase())) {
        locatedMedia.add(data);
      }
    }
    // media.insert(media.length, locatedMedia);
    if (search.length < 2) {
      media.insert(media.length, locatedMedia);
    } else {
      media.last = locatedMedia;
    }
    _goNext();
  }

  void searchRemoteData({required String search}) async {
    List searchedData = [];
    List locatedMedia = [];

    await SearchData(search)
        .getData()
        .then((value) => searchedData.addAll(value["posts"]));

    for (var data in searchedData) {
      locatedMedia.add(MediaControllerData(
        mediaID: data['id'],
        mediaTitle: data['title'],
        mediaImage: data['thumbnailUrl'],
        mediaYear: data['year'],
      ));
    }

    media.insert(media.length, locatedMedia);
    _goNext();
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
    media.insert(media.length, locatedMedia);
    _goNext();
  }
}
