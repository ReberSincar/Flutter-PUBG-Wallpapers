import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/controllers/fav_list_controller.dart';
import 'package:pubg_wallpaper/db/db.dart';
import 'package:pubg_wallpaper/enums/enums.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:get/get.dart';

import '../../services/file_operations.dart';
import '../../utils/utils.dart';

class ImageFavDialog extends StatelessWidget {
  ImageFavDialog({Key key, this.imageModel}) : super(key: key);
  final ImageModel imageModel;
  final FileOperations fileOperations = FileOperations.getInstance();
  final DB db = DB.getInstance();
  final FavController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black,
      child: Stack(
        children: [
          GestureZoomBox(
            maxScale: 5.0,
            doubleTapScale: 2.0,
            duration: Duration(milliseconds: 100),
            child: CachedNetworkImage(
              imageUrl: imageModel.originalImage,
              // fit: BoxFit.contain,
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                );
              },
            ),
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
                            await fileOperations
                                .saveImageUrl(imageModel.originalImage);
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
                                url: imageModel.originalImage);
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
                            Utils.showCropImageDialog(imageModel.originalImage);
                          },
                        ),
                      ),
                      Expanded(
                        child: Obx(() {
                          return MaterialButton(
                            child: Icon(
                              Icons.favorite_rounded,
                              color: controller.pubgFavList.any(
                                      (element) => element.id == imageModel.id)
                                  ? darkColor
                                  : Colors.white,
                            ),
                            onPressed: () async {
                              if (controller.pubgFavList.any(
                                  (element) => element.id == imageModel.id)) {
                                db.removePubgpinkImage(imageModel);
                              } else {
                                db.addPubgImage(imageModel);
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
                            Utils.shareImage(imageModel.originalImage);
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
