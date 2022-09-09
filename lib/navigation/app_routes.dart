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

}

abstract class _Paths {
  static const splash = '/splash';
  static const lava = '/lavaScreen';
  static const homePage = '/homePage';
  static const setting = '/setting';
  static const colorPickPage = '/colorPickPage';

}