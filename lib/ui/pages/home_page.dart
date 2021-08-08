import 'package:get/get.dart';
// import 'package:pubg_wallpaper/ads/ads.dart';
import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/controllers/fav_list_controller.dart';
import 'package:pubg_wallpaper/controllers/pubg_controller.dart';
import 'package:pubg_wallpaper/controllers/position_controller.dart';
import 'package:pubg_wallpaper/ui/pages/pubg_wallpapers.dart';
import 'package:pubg_wallpaper/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // GoogleAds _ads = GoogleAds.getInstance();

  @override
  void initState() {
    // _ads.showBannerAd();
    Get.put(PubgImagesController());
    Get.put(FavController());
    Get.put(PositionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: PubgWallpapers(),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.favorite_rounded),
              Text(
                "Favori",
                style: TextStyle(fontSize: 8, color: Colors.white),
              )
            ],
          ),
          backgroundColor: lightColor.withOpacity(0.7),
          onPressed: () {
            Utils.showFavoriteDialog();
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 50,
      centerTitle: true,
      backgroundColor: Colors.black,
      title: Text(
        'PUBG Wallpapers',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
    );
  }
}
