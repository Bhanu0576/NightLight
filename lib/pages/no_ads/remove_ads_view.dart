import 'dart:io';

import 'package:demo1212/pages/no_ads/remove_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../appStyle/app_color.dart';
import '../../appStyle/app_dimension.dart';
import '../../appStyle/assets_images.dart';

class RemmoveAdsView extends StatelessWidget {
// final bool _kAutoConsume = Platform.isIOS || true;

// const String _kConsumableId = 'com.app.product';
// const List<String> _kProductIds = <String>[
//   _kConsumableId,
// ];



  @override
  Widget build(BuildContext context) {
    
    // ignore: dead_code
    return GetBuilder<RemoveAdsController>(builder: (controller){
      
      return Scaffold(
        backgroundColor: AppColors.colorBlueDark,
        appBar: AppBar(
          elevation: 0,
          title: Text("Subscription"),
          backgroundColor: AppColors.colorBlueDark,
        ),
        
          body: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                // height: ,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.thirty)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset(
                                  AssetsBase.secure_reliable,
                                  height: AppDimensions.fifty,
                                 width: AppDimensions.fifty,
                              ),
                              Text("Secure &"),
                              Text("Reliable"),

                            ],
                          ),
                        ),
                        
                        Image.asset(
                                  AssetsBase.vertical_line,
                                  height: AppDimensions.sixty,
                                 width: 2,
                              ),
                        
                        Container(
                          child: Column(
                            children: [
                              Image.asset(
                                  AssetsBase.fastest_Service,
                                  height: AppDimensions.fifty,
                                 width: AppDimensions.fifty,
                              ),
                              Text("Fastest"),
                              Text("Service"),

                            ],
                          ),
                        ),

                        Container(
                          child: Image.asset(
                                    AssetsBase.vertical_line,
                                    height: AppDimensions.sixty,
                                   width: 2,
                                ),
                        ),

                        Container(
                          child: Column(
                            children: [
                              Image.asset(
                                  AssetsBase.no_add_interuption,
                                  height: AppDimensions.fifty,
                                 width: AppDimensions.fifty,
                              ),
                              Text("NO Ad"),
                              Text("Interruption"),

                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    
                    SizedBox(height: 30),

                    Container(child: Text("Subscribe Now", style: TextStyle(color: AppColors.colorBlueDark, fontSize: 17, fontWeight: FontWeight.bold),),  ),

                    SizedBox(height: 20),


                    InkWell(
                      onTap: () {
                        controller.removeAdsSignin();

                      //   late PurchaseParam purchaseParam;

                      // if (Platform.isAndroid) {
                      //   purchaseParam = GooglePlayPurchaseParam(
                      //     productDetails: _products[0],
                      //   );
                      // } else {
                      //   purchaseParam = PurchaseParam(
                      //     productDetails: _products[0],
                      //   );
                      // }

                      // if (_products[0].id == _kConsumableId) {
                      //   _inAppPurchase.buyConsumable(
                      //       purchaseParam: purchaseParam,
                      //       autoConsume: _kAutoConsume);
                      // } else {
                      //   _inAppPurchase.buyNonConsumable(
                      //       purchaseParam: purchaseParam);
                      // }

                      },
                      child: Stack(
                        children: [
                    
                         Container(
                            width:  MediaQuery. of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(color: AppColors.colorBlueDark,   borderRadius: BorderRadius.circular(10), ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                    
                              children: [
                                const Text("1.99/ Life Time ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),  ),
                                const Text("Subcription",  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                             ],
                            ),
                          ),
                    
                          Positioned(
                            left: -10,
                            top: -11,
                            child: Container(
                              // transform: Matrix4.rotationZ(0.1),
                              child: Image.asset(
                                          AssetsBase.best_price_tag,
                                          height: AppDimensions.seventy,
                                         width: AppDimensions.seventy,
                                        
                              ),
                            ),
                          ),
                    
                    
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 50),


                    InkWell(
                      onTap: () {},
                      child: Text("Restore Purchase",  style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold, 
                      decoration: TextDecoration.underline,),),
                    ),
                    SizedBox(height: 10),


                    Container(
                      // padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text("Payment will be charge to your Apple ID Account at the"
                       "confirmation of purchase Subscription automatically renews unless",
                       textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.grey, fontSize: 12),),

                    ),

                  ],
                ),
              ),
            ],
          ),

      );
      

    });
  }
  

}