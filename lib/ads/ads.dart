import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';

class GoogleAds {
  static GoogleAds _googleAds;

  String _appAdID = 'ca-app-pub-7689183541070639~9777750696';

  //For Real Ads
  String _bannerAdID = 'ca-app-pub-7689183541070639/9621838020';
  String _interstitialAdID = 'ca-app-pub-7689183541070639/5554778113';
  String _appOpenAdID = "ca-app-pub-7689183541070639/5646933998";

  // For Test Ads
  // String _bannerAdID = BannerAd.testAdUnitId;
  // String _interstitialAdID = InterstitialAd.testAdUnitId;
  // String _appOpenAdID = FlutterAdmobAppOpen.testAppOpenAdId;

  MobileAdEvent interstitialEvent;
  MobileAdEvent bannerEvent;

  BannerAd bannerAd;
  InterstitialAd interstitialAd;

  MobileAdTargetingInfo targetingInfo;

  FlutterAdmobAppOpen openAppAd;

  GoogleAds._() {
    WidgetsFlutterBinding.ensureInitialized();
    openAppAd = FlutterAdmobAppOpen.instance;
    FirebaseAdMob.instance.initialize(appId: _appAdID);
    targetingInfo = MobileAdTargetingInfo(
      nonPersonalizedAds: false,
      childDirected: false,
      // testDevices: <String>[
      //   '65D527E6780CED445C9A775506A0FF82',
      //   '357803516DADDAED8E419C60B980F94A'
      // ],
    );
    initAllAds();
  }

  static GoogleAds getInstance() {
    if (_googleAds == null) {
      _googleAds = new GoogleAds._();
    }
    return _googleAds;
  }

  initAllAds() {
    // Banner AD
    createBannerAd();

    // Interstitial AD
    createInterstitialAd();
  }

  showInterstitialAd() {
    if (interstitialEvent == MobileAdEvent.failedToLoad) {
      print('interstitialAd failedToLoad Show Method');
      createInterstitialAd();
    } else {
      interstitialAd.show();
    }
  }

  showOpenApp() async {
    await openAppAd.initialize(
      appId: _appAdID,
      appAppOpenAdUnitId: _appOpenAdID,
      targetingInfo: targetingInfo,
    );
  }

  createInterstitialAd() {
    interstitialAd = InterstitialAd(
      adUnitId: _interstitialAdID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print('WebView InterstitialAd Listener started');
        interstitialEvent = event;
        switch (event) {
          case MobileAdEvent.closed:
            print('interstitialAd closed');
            //createInterstitialAd();
            print('Open WebPlayer');
            createInterstitialAd();

            break;
          case MobileAdEvent.failedToLoad:
            print('interstitialAd failedToLoad');
            break;
          case MobileAdEvent.loaded:
            print('interstitialAd loaded');
            //_googleAds.showInterstitialAd();
            break;
          case MobileAdEvent.clicked:
            print('interstitialAd Clicked');
            break;
          case MobileAdEvent.impression:
            print('interstitialAd Impression');
            break;
          case MobileAdEvent.leftApplication:
            print('interstitialAd leftApplication');
            break;
          case MobileAdEvent.opened:
            print('interstitialAd opened');
            break;
          default:
            print('interstitialAd event default case');
        }
      },
    )..load();
  }

  createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: _bannerAdID,
      size: AdSize.fullBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        bannerEvent = event;
        switch (event) {
          case MobileAdEvent.closed:
            print('BannerAd event closed');
            break;
          case MobileAdEvent.failedToLoad:
            print('BannerAd event failedToLoad');
            break;
          case MobileAdEvent.loaded:
            print('BannerAd event loaded');
            break;
          case MobileAdEvent.clicked:
            print('BannerAd event Clicked');
            break;
          case MobileAdEvent.impression:
            print('BannerAd event Impression');
            break;
          case MobileAdEvent.leftApplication:
            print('BannerAd event leftApplication');
            break;
          case MobileAdEvent.opened:
            print('BannerAd event opened');
            break;
          default:
            print('BannerAd event default case');
        }
      },
    )..load();
  }

  showBannerAd() async {
    if (bannerAd == null) {
      createBannerAd();
      bannerAd
        ..show(
          anchorType: AnchorType.bottom,
        );
    } else {
      bannerAd
        ..show(
          anchorType: AnchorType.bottom,
        );
    }
  }

  disposeBannerAd() {
    bannerAd?.dispose();
    bannerAd = null;
  }
}
