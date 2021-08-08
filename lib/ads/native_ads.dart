// import 'package:pubg_wallpaper/ui/widgets/custom_circular_progress.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';

// class NativeAdClass {
//   final controller = NativeAdmobController();
//   String _nativeAdID = 'ca-app-pub-7689183541070639/4333852325';
//   //String _nativeAdID = NativeAd.testAdUnitId;
//   NativeAdClass() {
//     controller.setNonPersonalizedAds(false);
//     // controller.setTestDeviceIds([
//     //   '65D527E6780CED445C9A775506A0FF82',
//     //   '357803516DADDAED8E419C60B980F94A'
//     // ]);
//   }

//   createNativeAd() {
//     return NativeAdmob(
//       adUnitID: _nativeAdID,
//       loading: CustomCircularProgressBar(),
//       error: Container(
//         color: Colors.black,
//         child: Center(
//           child: Image.asset("assets/pubg_logo.png"),
//         ),
//       ),
//       controller: controller,
//       type: NativeAdmobType.full,
//     );
//   }
// }
