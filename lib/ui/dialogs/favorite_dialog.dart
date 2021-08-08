// import 'package:pubg_wallpaper/ads/ads.dart';
// import 'package:pubg_wallpaper/ads/native_ad_container.dart';
import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/controllers/fav_list_controller.dart';
import 'package:pubg_wallpaper/controllers/pubg_controller.dart';
import 'package:pubg_wallpaper/controllers/position_controller.dart';
import 'package:pubg_wallpaper/db/db.dart';
import 'package:pubg_wallpaper/db/firestore_db.dart';
import 'package:pubg_wallpaper/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class FavoriteDialog extends StatefulWidget {
  FavoriteDialog({Key key}) : super(key: key);

  @override
  _FavoriteDialogState createState() => _FavoriteDialogState();
}

class _FavoriteDialogState extends State<FavoriteDialog> {
  final DBService db = Get.find();

  final FireStoreDB fireStoreDB = Get.find();

  final FavController controller = Get.find();

  final PositionController positionController = Get.find();

  var favList;

  final PubgImagesController pubgController = Get.find();
  String appBarText;

  // GoogleAds _ads = GoogleAds.getInstance();

  @override
  void initState() {
    favList = controller.pubgFavList;
    appBarText = "PUBG";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          AppBar(
            elevation: 50,
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text(
              '$appBarText Favorite Wallpapers',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
          Obx(
            () => favList.length == 0
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [lightColor, Colors.black],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: EmptyWidget(
                        title: 'No Favorite Wallpapers',
                        image: 'assets/empty.png',
                        titleTextStyle: Theme.of(context)
                            .typography
                            .dense
                            .headline5
                            .copyWith(color: Color(0xff9da9c7)),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [lightColor, Colors.black],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(2, index.isEven ? 3 : 4),
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        itemCount: favList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return
                              // index == 0 || index % 5 != 0 ?
                              GestureDetector(
                            onTap: () {
                              positionController.changePosition(index);
                              fireStoreDB.addViewCountPubg(
                                  favList[index].id, favList[index].viewCount);
                              // _ads.showInterstitialAd();
                              Utils.showImageFavDialog(favList[index]);
                            },
                            child: Center(
                              child: Card(
                                color: Colors.black87,
                                child: CachedNetworkImage(
                                  imageUrl: favList[index].thumbImage,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(3.0, 3.0),
                                          blurRadius: 5.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) {
                                    return Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          );
                          // : NativeAdContainer();
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
