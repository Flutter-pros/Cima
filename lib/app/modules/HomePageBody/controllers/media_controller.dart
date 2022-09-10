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
  String? mediaAging;
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
      mediaAging = data["mpaa"];
    });
  }
}

class DrawerControllerData {
  late String mainCategoryID;
  late String mainCategoryName;
  late List mainCategorySubCategories;
  DrawerControllerData(
      {required this.mainCategoryID,
      required this.mainCategoryName,
      required this.mainCategorySubCategories});
}

class MediaController extends GetxController {
  //* to controll the state of the drawer
  RxList drawer = [].obs;
  //* we will make the default state of the myhomepage to show the arabic movies
  RxList media = [].obs;
  //! we will use the below variable to target the latest state event the existence of unnecessary states (wil be overrwitten)
  RxInt targettedMediaState = (-1).obs;
  //* this will be used to check if the previous button should be activated or not
  RxBool isPreviousActivated = false.obs;
  //! we use the below two variable to configure out if we used any filters before to update the media.last unless we will insert the data
  RxBool isFiltersTriggered = false.obs;
  RxInt appliedFilters = 0.obs;
  //! we use the below variable to manage the stacked filters scroll and the gridview scroll
  RxBool isAnyFilterExpanded = false.obs;
  //* the below variable is used to reserve the current media index to refrence it in the movie info screen and to content screen
//! used to make insure that the search will applied on last state of media
  RxBool isSearchEnabled = false.obs;
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
    targettedMediaState.value++;
    if (media.length > 1) {
      isPreviousActivated.value = true;
    }
  }

  void _insertMediaState(List mediaData) {
    if (media.length > 10) {
      media.removeAt(0);
    }
    _goNext();
    media[targettedMediaState.value] = mediaData;
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
        (media.isNotEmpty)
            ? media.last = locatedMedia
            : media.insert(
                media.length,
                locatedMedia
                    .where(
                        (element) => locatedMediaIDs.contains(element.mediaID))
                    .toList());

        _insertMediaState(locatedMedia);
        // _goNext();
      }
    } else {
      _insertMediaState(locatedMedia);
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
    // media.add([]);
    List locatedMedia = [];
    for (var data in media.last) {
      if (data.mediaTitle.toLowerCase().contains(search.toLowerCase())) {
        locatedMedia.add(data);
      }
    }
    // media.insert(media.length, locatedMedia);
    // if (isSearchEnabled.value) {
    // media.insert(media.length, locatedMedia);
    // media.removeLast();

    _insertMediaState(locatedMedia);
    // } else {
    // _insertMediaState(locatedMedia);
    // }
    // _goNext();
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

    _insertMediaState(locatedMedia);
    // _goNext();
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
    // _goNext();
    _insertMediaState(locatedMedia);
  }

  void getDrawerData() async {
    List drawerData = [];
    List locatedMedia = [];
    await DrawerData().getData().then((value) => drawerData.addAll(value));
    for (var post in drawerData) {
      locatedMedia.add(DrawerControllerData(
        mainCategoryID: post['id'],
        mainCategoryName: post['name'],
        mainCategorySubCategories: post['children'],
      ));
    }
    drawer.value = locatedMedia;
  }
}
