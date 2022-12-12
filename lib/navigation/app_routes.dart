// coverage:ignore-file
part of 'app_pages.dart';

/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
abstract class Routes {
  static const splash = _Paths.splash;
  static const lava = _Paths.lava;
  static const homePage = _Paths.homePage;
  static const setting = _Paths.setting;
  static const colorPickPage = _Paths.colorPickPage;
  static const settingScreen = _Paths.settingScreen;
  static const showCaseMain = _Paths.showCaseMain;
  static const htmlScreenMain = _Paths.htmlScreenMain;
  static const contactUsPage = _Paths.contactUsPage;
  static const removeAdsPage = _Paths.removeAdsPage;


  //static const customShowCaseWidget = _Paths.customShowCaseWidget;
}

abstract class _Paths {
  static const splash = '/splash';
  static const lava = '/lavaScreen';
  static const homePage = '/homePage';
  static const setting = '/setting';
  static const colorPickPage = '/colorPickPage';
  static const settingScreen = '/settingScreen';
  static const showCaseMain = '/showCaseMain';
  static const htmlScreenMain = '/htmlScreenView';
  static const contactUsPage = '/contactUsPage';
  static const removeAdsPage = '/removeAdsPage';

  //static const customShowCaseWidget = '/customShowCaseWidget';
}