// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class RemoveAdsController extends GetxController {
  final bool _kAutoConsume = Platform.isIOS || true;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<PurchaseDetails> purchaseDetailsList = <PurchaseDetails>[];

  bool inAppVal = false;

  static const String _kConsumableId = 'com.app.product';
  static const List<String> _kProductIds = <String>[
    _kConsumableId,

  ];

  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {});
    initStoreInfo();
    getLastPurchase();
    super.onInit();
  }

  removeAdsSignin() {
    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: _products[0],
      );
    } else {
      purchaseParam = PurchaseParam(
        productDetails: _products[0],
      );
    }

    if (_products[0].id == _kConsumableId) {
      _inAppPurchase.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
    } else {
      _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  Future<void> getLastPurchase() async {
    final prefs = await SharedPreferences.getInstance();
    inAppVal = prefs.getBool('inAppPurchased') ?? false;
    update();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _products = <ProductDetails>[];
      _purchases = <PurchaseDetails>[];
      _notFoundIds = <String>[];
      update();
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      _products = productDetailResponse.productDetails;
      _purchases = <PurchaseDetails>[];
      _notFoundIds = productDetailResponse.notFoundIDs;
      update();
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      _products = productDetailResponse.productDetails;
      _purchases = <PurchaseDetails>[];
      _notFoundIds = productDetailResponse.notFoundIDs;
      update();
      return;
    }

    final List<String> consumables = await ConsumableStore.load();

    _products = productDetailResponse.productDetails;
    _notFoundIds = productDetailResponse.notFoundIDs;
    update();
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      update();
    } else {
      _purchases.add(purchaseDetails);
      update();
    }
  }

  Future<void> _listenToPurchaseUpdated(purchaseDetailsList) async {
    print("purchaseDetailsList $purchaseDetailsList");
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      print("purchaseDetails $purchaseDetails");
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("PurchaseStatus.pending ${PurchaseStatus.pending}");
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        print("PurchaseStatus.error ${PurchaseStatus.error}");
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        print("PurchaseStatus.status ${purchaseDetails.status}");

        //--------------------------------
        // if (purchaseDetails.status == PurchaseStatus.purchased) {
        //   final prefs = await SharedPreferences.getInstance();
        //   prefs.setBool("inPurchased", true);
        // }
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("inAppPurchased", true);
          inAppVal = prefs.getBool('inAppPurchased')!;
          update();
          print("Purchase detale status ${purchaseDetails.status} ");
        }

        //----------------------------------
        final bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
      if (Platform.isAndroid) {
        if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

class ConsumableStore {
  static const String _kPrefKey = 'consumables';
  static Future<void> _writes = Future<void>.value();

  static Future<void> save(String id) {
    _writes = _writes.then((void _) => _doSave(id));
    return _writes;
  }

  static Future<void> consume(String id) {
    _writes = _writes.then((void _) => _doConsume(id));
    return _writes;
  }

  static Future<List<String>> load() async {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
        <String>[];
  }

  static Future<void> _doSave(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.add(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

  static Future<void> _doConsume(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }
}
