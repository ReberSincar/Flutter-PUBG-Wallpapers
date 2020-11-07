import 'package:pubg_wallpaper/ads/ads.dart';
import 'package:pubg_wallpaper/db/db.dart';
import 'package:pubg_wallpaper/services/file_operations.dart';
import 'package:pubg_wallpaper/ui/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GoogleAds.getInstance().showOpenApp();
  FileOperations.getInstance();
  DB.getInstance();
  await GetStorage.init("PUBG");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GoogleAds.getInstance();
  runApp(
    GetMaterialApp(
      home: HomePage(),
    ),
  );
}
