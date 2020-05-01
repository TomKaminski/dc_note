import 'dart:io';

import 'package:ads/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class AppAds {
  static Ads _ads;

  static final String _appId =
      Platform.isAndroid ? 'ca-app-pub-9001976910782778~3249431672' : '---';

  static final String _bannerUnitId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : '---';

  static final String _screenUnitId =
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : '---';

  /// Assign a listener.
  static MobileAdListener _eventListener = (MobileAdEvent event) {
    if (event == MobileAdEvent.clicked) {
      print("_eventListener: The opened ad is clicked on.");
    }
  };

  static void init() => _ads ??= Ads(
        _appId,
        bannerUnitId: _bannerUnitId,
        screenUnitId: _screenUnitId,
        keywords: <String>[
          'beauty',
          'cosmetics',
          'kosmetyki',
          'make-up',
          'makijaż'
        ],
        childDirected: false,
        testing: true,
        listener: _eventListener,
      );

  /// Call this static function in your State object's initState() function.
  static void showBanner(
          {String adUnitId,
          AdSize size,
          List<String> keywords,
          String contentUrl,
          bool childDirected,
          List<String> testDevices,
          bool testing,
          MobileAdListener listener,
          State state,
          double anchorOffset,
          AnchorType anchorType}) =>
      _ads?.showBannerAd(
          adUnitId: adUnitId,
          size: size,
          keywords: keywords,
          contentUrl: contentUrl,
          childDirected: childDirected,
          testDevices: testDevices,
          testing: testing,
          listener: listener,
          state: state,
          anchorOffset: anchorOffset,
          anchorType: anchorType);

  /// Call this static function in your State object's initState() function.
  static void showFullscreen(
          {String adUnitId,
          AdSize size,
          List<String> keywords,
          String contentUrl,
          bool childDirected,
          List<String> testDevices,
          bool testing,
          MobileAdListener listener,
          State state}) =>
      _ads?.showFullScreenAd(
          adUnitId: adUnitId,
          keywords: keywords,
          contentUrl: contentUrl,
          childDirected: childDirected,
          testDevices: testDevices,
          testing: testing,
          listener: listener,
          state: state);

  static void hideBanner() => _ads?.closeBannerAd();

  /// Remember to call this in the State object's dispose() function.
  static void dispose() => _ads?.dispose();
}
