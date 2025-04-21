import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:e_mart/src/core/utils/helper_functions/helper_functions.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/presentation/component/detect_visibility.dart';
import 'package:e_mart/src/features/products/presentation/component/product_card.dart';
import 'package:e_mart/src/features/products/presentation/component/product_grid_shimmer.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_controller.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  StreamSubscription? _internetConnectivityStream;

  @override
  void initState() {
    _internetConnectivityStream = HelperFunctions.internetConnectivityChecker();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(productProvider.notifier).fetchAllProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    _internetConnectivityStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductGeneric productController = ref.watch(productProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              productController.products!.isEmpty
                  ? ProductGridShimmer()
                  : Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),

                        itemCount: productController.products?.length ?? 0,
                        itemBuilder: (context, index) {
                          Product product = productController.products![index];
                          return ProductCard(product: product);
                        },
                      ),
                      DetectVisibility(),
                    ],
                  ),
        ),
      ),
    );
  }
}
