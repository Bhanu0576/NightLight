import 'dart:io';
class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";  //'ca-app-pub-5357969312383027/4963477712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5357969312383027/9465975297'; //ca-app-pub-3906841028286221/7447706990
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";   //'ca-app-pub-5357969312383027/6001227217';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5357969312383027/1060640153'; //ca-app-pub-3906841028286221/5751481943  
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }
}