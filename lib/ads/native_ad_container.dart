// import 'package:flutter/material.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';

// import 'native_ads.dart';

// class NativeAdContainer extends StatefulWidget {
//   NativeAdContainer();
//   @override
//   _NativeAdContainerState createState() => _NativeAdContainerState();
// }

// class _NativeAdContainerState extends State<NativeAdContainer> {
//   NativeAdClass _nativeAdClass = NativeAdClass();
//   double _firstHeight = 0;
//   double _adHeight = 250;
//   @override
//   void initState() {
//     _nativeAdClass.controller.stateChanged.listen((state) {
//       {
//         switch (state) {
//           case AdLoadState.loading:
//             print('NativeAd event loading');
//             if (this.mounted) {
//               setState(() {
//                 _firstHeight = 0;
//               });
//             }

//             break;
//           case AdLoadState.loadError:
//             print('NativeAd event loadError');
//             if (this.mounted) {
//               setState(() {
//                 _firstHeight = 0;
//               });
//             }
//             break;
//           case AdLoadState.loadCompleted:
//             print('NativeAd event loadCompleted');
//             if (this.mounted) {
//               setState(() {
//                 _firstHeight = _adHeight;
//               });
//             }
//             break;
//         }
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nativeAdClass.controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: _firstHeight,
//       child: _nativeAdClass.createNativeAd(),
//     );
//   }
// }
