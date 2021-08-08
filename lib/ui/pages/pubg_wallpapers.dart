// import 'package:pubg_wallpaper/ads/ads.dart';
// import 'package:pubg_wallpaper/ads/native_ad_container.dart';
import 'package:pubg_wallpaper/constants/colors.dart';
import 'package:pubg_wallpaper/controllers/fav_list_controller.dart';
import 'package:pubg_wallpaper/controllers/pubg_controller.dart';
import 'package:pubg_wallpaper/controllers/position_controller.dart';
import 'package:pubg_wallpaper/db/firestore_db.dart';
import 'package:pubg_wallpaper/models/image.dart';
import 'package:pubg_wallpaper/ui/widgets/custom_circular_progress.dart';
import 'package:pubg_wallpaper/ui/widgets/image_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';

class PubgWallpapers extends StatefulWidget {
  PubgWallpapers({Key key}) : super(key: key);

  @override
  _PubgWallpapersState createState() => _PubgWallpapersState();
}

class _PubgWallpapersState extends State<PubgWallpapers>
    with AutomaticKeepAliveClientMixin {
  List<ImageModel> trendList = [];
  var scrollController = ScrollController();
  final PositionController positionController = Get.find();
  final PubgImagesController pubgController = Get.find();
  final FavController favController = Get.find();
  final FireStoreDB fireStoreDB = Get.find();
  QuerySnapshot collectionState;

  // GoogleAds _ads = GoogleAds.getInstance();
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0)
          print('ListView scroll at top');
        else {
          print('ListView scroll at bottom');
          try {
            pubgController.getDocumentsNext(); // Load next documents

          } catch (e) {
            print("No More Document");
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [lightColor, Colors.black],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter),
      ),
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Obx(() => buildAllWallpapers()),
        ],
      ),
    );
  }

  Container buildWallpaperText(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 3),
      width: Get.width,
      child: Text(
        'All Wallpapers',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        textAlign: TextAlign.start,
      ),
    );
  }

  Container buildAllWallpapers() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: Get.height,
      child: pubgController.listDocument.length != 0
          ? RefreshIndicator(
              onRefresh: () {
                return pubgController.getDocuments();
              },
              color: lightColor,
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                crossAxisCount: 4,
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(2, index.isEven ? 3 : 4),
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                itemCount: pubgController.listDocument.length,
                itemBuilder: (BuildContext context, int index) {
                  return ImageContainer(
                    index: index,
                    onIncreaseView: () {
                      _imageContainerViewCount(index);
                    },
                  );
                  // return index == 0 || index % 5 != 0
                  //     ? ImageContainer(
                  //         index: index,
                  //         onIncreaseView: () {
                  //           _imageContainerViewCount(index);
                  //         },
                  //       )
                  //     : NativeAdContainer();
                },
              ),
            )
          : CustomCircularProgressBar(),
    );
  }

  _imageContainerViewCount(int index) {
    // _ads.showInterstitialAd();
    positionController.changePosition(index);
    fireStoreDB.addViewCountPubg(pubgController.listDocument[index].id,
        pubgController.listDocument[index].viewCount);
    pubgController.addViewCount(index);
    favController.addPubgViewCountWithID(pubgController.listDocument[index].id);
    Utils.showImageDialog(pubgController.listDocument);
  }
}
