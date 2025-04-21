import 'package:e_mart/src/features/products/presentation/view_model/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:visibility_detector/visibility_detector.dart";
import 'package:flutter/material.dart';
class DetectVisibility extends ConsumerStatefulWidget {
  const DetectVisibility({super.key});

  @override
  ConsumerState<DetectVisibility> createState() => _DetectVisibilityState();
}

class _DetectVisibilityState extends ConsumerState<DetectVisibility> {
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key("Load More Images"),
      onVisibilityChanged: (info) async {
        double visibleFractionPercentage = info.visibleFraction * 100;
        if(visibleFractionPercentage >= 20){
          await ref.read(productProvider.notifier).fetchAllProducts();
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
