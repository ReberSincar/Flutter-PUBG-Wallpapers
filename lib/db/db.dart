import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:pubg_wallpaper/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

class DBService extends GetxService {
  GetStorage pubgBox;

  @override
  onInit() {
    pubgBox = GetStorage("PUBG");
    super.onInit();
  }

  addPubgImage(ImageModel image) {
    List<dynamic> list = getPubgImages();
    String mapToString = jsonEncode(image.toMap());
    if (!list.contains(mapToString)) {
      list.add(mapToString);
    }
    pubgBox.write('fav_list', list);
    Utils.showShortToast('Added to Favorites');
  }

  getPubgImages() {
    return pubgBox.read('fav_list') ?? [];
  }

  removePubgpinkImage(ImageModel image) {
    List<dynamic> list = getPubgImages();
    list.removeWhere((element) => jsonDecode(element)['id'] == image.id);
    pubgBox.write('fav_list', list);
    Utils.showShortToast('Removed from Favorites');
  }

  getPubgImageModelList() {
    List<dynamic> list = getPubgImages();
    List<ImageModel> imageModelList = [];
    for (String item in list) {
      ImageModel model = ImageModel.fromMap(jsonDecode(item));
      print(model.id);
      imageModelList.add(model);
    }
    return imageModelList;
  }

  removeAllPubgImages() {
    pubgBox.remove('fav_list');
  }
}
