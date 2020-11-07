import 'dart:io';

import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/enums/enums.dart';
import 'package:pubg_wallpaper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperTypeDialog extends StatelessWidget {
  const WallpaperTypeDialog(
      {Key key, this.url, this.file, this.wallpaperSetType})
      : super(key: key);
  final url;
  final File file;
  final WallpaperSetType wallpaperSetType;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightColor.withOpacity(0.7),
      elevation: 15,
      content: Container(
        //width: Get.width * 0.9,
        height: Get.height * 0.225,
        child: wallpaperSetType == WallpaperSetType.Auto
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        await Utils.setBackgroundUrl(
                            url, WallpaperManager.HOME_SCREEN);
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: Get.width * 0.025),
                          Text(
                            'Home Screen',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        await Utils.setBackgroundUrl(
                            url, WallpaperManager.LOCK_SCREEN);
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: Get.width * 0.025),
                          Text(
                            'Lock Screen',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        await Utils.setBackgroundUrl(
                            url, WallpaperManager.BOTH_SCREENS);
                        Get.back(result: wallpaperSetType);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone_android_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: Get.width * 0.025),
                          Text(
                            'Home and Lock',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        await Utils.setBackgroundFile(
                            file, WallpaperManager.HOME_SCREEN);
                        Get.back(result: wallpaperSetType);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: Get.width * 0.025),
                          Text(
                            'Home Screen',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        await Utils.setBackgroundFile(
                            file, WallpaperManager.LOCK_SCREEN);
                        Get.back(result: wallpaperSetType);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: Get.width * 0.025),
                          Text(
                            'Lock Screen',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () async {
                        await Utils.setBackgroundFile(
                            file, WallpaperManager.BOTH_SCREENS);
                        Get.back(result: wallpaperSetType);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone_android_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: Get.width * 0.025),
                          Text(
                            'Home and Lock',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
