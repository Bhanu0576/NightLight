import 'package:demo1212/pages/ShowCasepage/ShowCaseMain.dart';
import 'package:demo1212/pages/contact_us/contact_us_bindings.dart';
import 'package:demo1212/pages/contact_us/contact_us_view.dart';
import 'package:demo1212/pages/htmlscreen/htmlViewScreen.dart';
import 'package:get/get.dart';

import 'package:demo1212/pages/HomePage/home_page_binding.dart';
import 'package:demo1212/pages/HomePage/home_page_view.dart';
import 'package:demo1212/pages/colorPickPage/color_pick_binding.dart';
import 'package:demo1212/pages/colorPickPage/color_pick_screen.dart';
import 'package:demo1212/pages/splash/splash_page-binding.dart';
import 'package:demo1212/pages/splash/splash_page_view.dart';

// import '../pages/HomePage/lavaScreen/lava_screen_binding.dart';
// import '../pages/HomePage/lavaScreen/lava_screen_view.dart';
import '../pages/lavaScreen/lava_screen_binding.dart';
import '../pages/lavaScreen/lava_screen_view.dart';
import '../pages/no_ads/remove_ads_bindings.dart';
import '../pages/no_ads/remove_ads_view.dart';
import '../settings/setting_screen_binding.dart';
import '../settings/setting_screen_view.dart';

part 'app_routes.dart';

/// Contains the list of pages or routes taken across the whole application.
/// This will prevent us in using context for navigation. And also providing
/// the blocs required in the next named routes.
///
/// [pages] : will contain all the pages in the application as a route
/// and will be used in the material app.
/// Will be ignored for test since all are static values and would not change.
class AppPages {

  static var transitionDuration = const Duration(
    milliseconds: 250,
  );
  // static const initial = Routes.firstPage;
  // static const initial1 = Routes.dashBoardPage;
  static const initial = Routes.splash;

  static final pages = [
    GetPage<dynamic>(
      name: _Paths.lava,
      transitionDuration: transitionDuration,
      page: LavaScreen.new,
      binding: LavaScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.splash,
      transitionDuration: transitionDuration,
      page: SplashPage.new,
      binding: SplashPageBiding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.homePage,
      transitionDuration: transitionDuration,
      page: HomePage.new,
      binding: HomePageBiding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.colorPickPage,
      transitionDuration: transitionDuration,
      page: ColorPickScreen.new,
      binding: ColorPickPageBiding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: _Paths.settingScreen,
      transitionDuration: transitionDuration,
      page: SettingScreen.new,
      binding: SettingScreenBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage<dynamic>(
      name: _Paths.showCaseMain,
      transitionDuration: transitionDuration,
      //page: ShowCaseMain.new,
      page: ShowCaseMain.new,
      transition: Transition.fadeIn,
    ),

    GetPage<dynamic>(
      name: _Paths.htmlScreenMain, 
      transitionDuration: transitionDuration,
      page: HtmlScreenView.new,
      transition: Transition.fadeIn,
      ),
      GetPage<dynamic>(
      name: _Paths.contactUsPage, 
      transitionDuration: transitionDuration,
      page: ContactUsView.new,
      binding: ContactUsPageBinding(),
      transition: Transition.fadeIn,
      ),
      GetPage<dynamic>(
      name: _Paths.removeAdsPage,
      transitionDuration: transitionDuration,
      page: RemmoveAdsView.new,
      binding: RemoveAdsBinding(),
      transition: Transition.fadeIn,
    ),


  ];
}