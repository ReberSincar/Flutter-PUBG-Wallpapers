// import 'package:pubg_wallpaper/ads/ads.dart';
import 'package:pubg_wallpaper/db/db.dart';
import 'package:pubg_wallpaper/db/firestore_db.dart';
import 'package:pubg_wallpaper/services/file_service.dart';
import 'package:pubg_wallpaper/ui/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init("PUBG");
  // await GoogleAds.getInstance().showOpenApp();
  Get.put(FileIOService());
  Get.put(DBService());
  Get.put(FireStoreDB());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // GoogleAds.getInstance();
  runApp(
    GetMaterialApp(
      home: HomePage(),
    ),
  );
}
