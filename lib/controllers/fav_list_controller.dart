import 'dart:convert';

import 'package:pubg_wallpaper/db/db.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:get/get.dart';

class FavController extends GetxController {
  DB db = DB.getInstance();
  var pubgFavList = List<ImageModel>().obs;
  @override
  void onInit() {
    List<ImageModel> dbImages = db.getPubgImageModelList();
    pubgFavList = dbImages.obs;
    listenBox();
    super.onInit();
  }

  listenBox() {
    db.pubgBox.listenKey('fav_list', (value) {
      pubgFavList.clear();
      for (String item in value) {
        ImageModel image = ImageModel.fromMap(jsonDecode(item));
        pubgFavList.add(image);
      }
      update();
    });
  }

  addPubgFavCount(int position) {
    ImageModel model = pubgFavList[position];
    model.favCount += 1;
    pubgFavList[position] = model;
    update();
  }

  addPubgViewCount(int position) {
    ImageModel model = pubgFavList[position];
    model.viewCount += 1;
    pubgFavList[position] = model;
    update();
  }

  addPubgViewCountWithID(String id) {
    int position = pubgFavList.indexWhere((e) => e.id == id);
    if (position != -1) {
      ImageModel model = pubgFavList[position];
      model.viewCount += 1;
      pubgFavList[position] = model;
      update();
    }
  }

  addPubgFavCountWithID(String id) {
    int position = pubgFavList.indexWhere((e) => e.id == id);
    if (position != -1) {
      ImageModel model = pubgFavList[position];
      model.favCount += 1;
      pubgFavList[position] = model;
      update();
    }
  }
}
