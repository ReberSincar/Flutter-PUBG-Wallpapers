import 'dart:io';

import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';

import '../../utils/utils.dart';

class CropImageDialog extends StatelessWidget {
  const CropImageDialog({
    Key key,
    @required this.sampleFile,
    @required this.cropKey,
  }) : super(key: key);

  final File sampleFile;
  final GlobalKey<CropState> cropKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black,
      child: Stack(
        children: [
          Crop.file(
            sampleFile,
            key: cropKey,
            alwaysShowGrid: true,
            aspectRatio: Get.width / Get.height,
            onImageError: (exception, stackTrace) {
              Utils.showShortToast('There is a problem');
              Get.back();
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 70),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  color: lightColor.withOpacity(0.7),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: MaterialButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.crop,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Crop & Set',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      onPressed: () async {
                        File file = await Utils.cropImage(cropKey, sampleFile);
                        Utils.showWallpaperTypeDialog(WallpaperSetType.Cropped,
                            file: file);
                      },
                    ),
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
