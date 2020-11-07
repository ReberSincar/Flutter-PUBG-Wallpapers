import 'dart:io';
import 'dart:typed_data';
import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:pubg_wallpaper/ui/dialogs/crop_image_dialog.dart';
import 'package:pubg_wallpaper/ui/dialogs/favorite_dialog.dart';
import 'package:pubg_wallpaper/ui/dialogs/image_dialog.dart';
import 'package:pubg_wallpaper/ui/dialogs/image_fav_dialog.dart';
import 'package:pubg_wallpaper/ui/dialogs/loading_dialog.dart';
import 'package:pubg_wallpaper/ui/dialogs/wallpaper_type_dialog.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:pubg_wallpaper/enums/enums.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class Utils {
  static showImageDialog(List<ImageModel> list) {
    Get.dialog(
      ImageDialog(list: list),
      barrierDismissible: false,
    );
  }

  static showCropImageDialog(String url) async {
    final cropKey = GlobalKey<CropState>();
    File sampleFile = await DefaultCacheManager().getSingleFile(url);
    Get.dialog(
      CropImageDialog(sampleFile: sampleFile, cropKey: cropKey),
      barrierDismissible: false,
    );
  }

  static showLoadingDialog() async {
    Get.dialog(
      LoadingAlertDialog(),
      barrierDismissible: false,
    );
  }

  static showFavoriteDialog() async {
    Get.dialog(
      FavoriteDialog(),
      barrierDismissible: false,
    );
  }

  static showImageFavDialog(ImageModel imageModel) async {
    Get.dialog(
      ImageFavDialog(imageModel: imageModel),
      barrierDismissible: false,
    );
  }

  static showWallpaperTypeDialog(WallpaperSetType setType,
      {String url, File file}) async {
    Get.dialog(
      WallpaperTypeDialog(
        url: url,
        file: file,
        wallpaperSetType: setType,
      ),
      barrierDismissible: true,
    ).then((value) => value == WallpaperSetType.Cropped ? Get.back() : null);
  }

  static setBackgroundUrl(String url, int wallpaperType) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, wallpaperType);
    print(result);
    showShortToast('Wallpaper Changed');
  }

  static setBackgroundFile(File file, int wallpaperType) async {
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, wallpaperType);
    print(result);
    showShortToast('Wallpaper Changed');
  }

  static cropImage(cropKey, sampleFile) async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: sampleFile,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );
    //showWallpaperTypeDialog(context, WallpaperSetType.Cropped, file: file);
    //Navigator.pop(context);
    debugPrint('$file');
    return file;
  }

  static shareImage(String url) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('PUBG Wallpaper', 'pubg.jpg', bytes, 'image/jpg',
        text:
            'For more pubg wallpapers : https://play.google.com/store/apps/details?id=com.rebersincar.pubgwallpapers');
  }

  static showShortToast(String text) {
    // Get.snackbar(
    //   caption,
    //   text,
    //   animationDuration: Duration(seconds: 2),
    //   backgroundColor: lightColor.withOpacity(0.7),
    //   colorText: Colors.white,
    //   isDismissible: true,
    // );
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: lightColor.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
