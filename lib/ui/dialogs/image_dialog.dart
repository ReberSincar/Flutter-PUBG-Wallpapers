// import 'package:pubg_wallpaper/ads/ads.dart';
import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/controllers/fav_list_controller.dart';
import 'package:pubg_wallpaper/controllers/pubg_controller.dart';
import 'package:pubg_wallpaper/controllers/position_controller.dart';
import 'package:pubg_wallpaper/db/db.dart';
import 'package:pubg_wallpaper/db/firestore_db.dart';
import 'package:pubg_wallpaper/enums/enums.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:get/get.dart';
import '../../services/file_service.dart';
import '../../utils/utils.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog({Key key, this.list}) : super(key: key);
  final List<ImageModel> list;
  final FileIOService fileService = Get.find();
  final DBService db = Get.find();
  final FireStoreDB fireStoreDB = Get.find();
  final FavController favController = Get.find();
  final PubgImagesController pubgController = Get.find();
  final PositionController positionController = Get.find();

  // final GoogleAds _ads = GoogleAds.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            controller: PageController(
                initialPage: positionController.position.value, keepPage: true),
            onPageChanged: (value) {
              // _ads.showInterstitialAd();
              positionController.changePosition(value);
              fireStoreDB.addViewCountPubg(
                  list[value].id, list[value].viewCount);
              favController.addPubgViewCountWithID(list[value].id);
              pubgController.addViewCountWithID(list[value].id);
            },
            itemBuilder: (context, position) {
              return GestureZoomBox(
                maxScale: 5.0,
                doubleTapScale: 2.0,
                duration: Duration(milliseconds: 100),
                child: CachedNetworkImage(
                  imageUrl: list[position].originalImage,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 25, left: 5, right: 5),
                child: Card(
                  color: lightColor.withOpacity(0.7),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          child: Icon(
                            Icons.download_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Utils.showLoadingDialog();
                            await fileService.saveImageUrl(
                                list[positionController.position.value]
                                    .originalImage);
                            Get.back();
                          },
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          child: Icon(
                            Icons.image_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Utils.showWallpaperTypeDialog(WallpaperSetType.Auto,
                                url: list[positionController.position.value]
                                    .originalImage);
                          },
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          child: Icon(
                            Icons.crop,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Utils.showCropImageDialog(
                                list[positionController.position.value]
                                    .originalImage);
                          },
                        ),
                      ),
                      Expanded(
                        child: Obx(() {
                          return MaterialButton(
                            child: Icon(Icons.favorite_rounded,
                                color: favController.pubgFavList.any(
                                        (element) =>
                                            element.id ==
                                            list[positionController
                                                    .position.value]
                                                .id)
                                    ? darkColor
                                    : Colors.white),
                            onPressed: () async {
                              if (favController.pubgFavList.any((element) =>
                                  element.id ==
                                  list[positionController.position.value].id)) {
                                db.removePubgpinkImage(
                                    list[positionController.position.value]);
                              } else {
                                db.addPubgImage(
                                    list[positionController.position.value]);
                                fireStoreDB.addFavCountPubg(
                                    list[positionController.position.value].id,
                                    list[positionController.position.value]
                                        .favCount);
                                pubgController.addFavCount(
                                    positionController.position.value);
                              }
                            },
                          );
                        }),
                      ),
                      Expanded(
                        child: MaterialButton(
                          child: Icon(
                            Icons.share_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Utils.shareImage(
                                list[positionController.position.value]
                                    .originalImage);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
