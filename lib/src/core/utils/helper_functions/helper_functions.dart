import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HelperFunctions{

  static String calculateDiscount({required Product product}){
    double discountAmount = product.price * (product.discountPercentage / 100);
    double discountedPrice = product.price - discountAmount;

    return discountedPrice.toStringAsFixed(2);
  }

  static StreamSubscription<InternetStatus> internetConnectivityChecker() {
    return InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          break;
        case InternetStatus.disconnected:
          BotToast.showText(
            text: "No Internet Connection",
            duration: const Duration(seconds: 5),
          );
          break;
      }
    });
  }

}
