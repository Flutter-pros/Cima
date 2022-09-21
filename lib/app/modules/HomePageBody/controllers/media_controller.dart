import 'package:get/get.dart';

import 'package:cima/app/data/movie_api.dart';
import 'package:cima/app/library/globals.dart' as globals;

class MediaControllerData {
  late String mediaID;
  late String mediaTitle;
  // String? mediaDescription;
  late String mediaImage;
  late String mediaYear;
  // String? mediaRating;
  // String? mediaDurationInMinutes;
  // List<String>? mediaGenre;
  // String? mediaWatchURL;
  // List? mediaDownloads;
  // String? mediaAging;
  // String? mediaQuality;
  // int? mediaEpisods;
  MediaControllerData({
    required this.mediaID,
    required this.mediaTitle,
    required this.mediaImage,
    required this.mediaYear,
  });
//   getMoreDetails() async {
//     await MediaData(mediaID: mediaID).getData().then((data) {
//       mediaDescription = data["story"];
//       mediaRating = data["imdbRating"];
//       mediaDurationInMinutes = data["runtime"];
//       mediaGenre = data["genre"].map((e) => e["name"]).toList();
//       mediaWatchURL = data["watch___url"];
//       mediaDownloads = data["downloads"];
//       mediaAging = data["mpaa"];
//       mediaQuality = data["quality"];
//       mediaEpisods = data["download"].length;
//     });
//     print("************all details are loaded&&&&&&&&&&&&&&&&&&&");
//   }
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
  //* used to cofigure if the screen is in the first place of stack of screens or not to configure the back button
  RxBool isFirstScreen = true.obs;
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
  RxBool isSeries = false.obs;
  void goPrevious() {
    if (media.length > 1) {
      (media.length - 1 > targettedMediaState.value)
          ? media.removeRange(targettedMediaState.value + 1, media.length)
          : media.removeLast();
    } else {
      isPreviousActivated.value = false;
      // media.removeLast();
    }
  }

  void _goNext() {
    targettedMediaState.value = targettedMediaState.value + 1;
    if (media.length > 1) {
      isPreviousActivated.value = true;
    }
  }

  void _insertMediaState(List mediaData) {
    if (media.length > 10) {
      media.removeAt(0);
    }
    // _goNext();

    (media.length - 1 > targettedMediaState.value)
        ? media[targettedMediaState.value + 1] = mediaData
        : media.add(mediaData);
  }

  void categorizeData({String? categoryID}) async {
    List filteredData = [];
    List locatedMedia = [];

    await CategorizedData(categoryID: categoryID ?? globals.categoryID)
        .getData()
        .then((value) => filteredData.addAll(value));

    for (var data in filteredData) {
      locatedMedia.add(MediaControllerData(
        mediaID: data['termID'] ?? data["id"],
        mediaTitle: data['title'],
        mediaImage: data['thumbnailUrl'],
        mediaYear: data['year'],
      ));
    }

    _goNext();

    _insertMediaState(locatedMedia);
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

  void filterCategorizedData(
      {required String filtereName, required String filterTermId}) async {
    List filteredData = [];
    List locatedMedia = [];
    await FilteredCategorizedData(
            filterTaxonomy: filtereName, filterTermID: filterTermId)
        .getData()
        .then((value) => filteredData.addAll(value));

    for (var data in filteredData) {
      locatedMedia.add(MediaControllerData(
        mediaID: data['term_id'] ?? data["id"] ?? data["termID"],
        mediaTitle: data['title'],
        mediaImage: data['thumbnailUrl'],
        mediaYear: data['year'],
      ));
    }
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
                  .where((element) => locatedMediaIDs.contains(element.mediaID))
                  .toList());

      _insertMediaState(locatedMedia);
    }
  }

  void searchLocalData({String search = ''}) {
    // media.add([]);
    List locatedMedia = [];
    for (var data in media[targettedMediaState.value]) {
      if (data.mediaTitle.toLowerCase().contains(search.toLowerCase())) {
        locatedMedia.add(data);
      }
    }
    _insertMediaState(locatedMedia);
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
    _goNext();

    _insertMediaState(locatedMedia);
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
    _goNext();
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
