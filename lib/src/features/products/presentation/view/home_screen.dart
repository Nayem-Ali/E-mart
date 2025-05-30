import 'dart:async';
import 'package:e_mart/src/core/constants/app_images_path.dart';
import 'package:e_mart/src/core/router/routes_name.dart';
import 'package:e_mart/src/core/utils/helper_functions/helper_functions.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/presentation/component/detect_visibility.dart';
import 'package:e_mart/src/features/products/presentation/component/product_card.dart';
import 'package:e_mart/src/features/products/presentation/component/product_grid_shimmer.dart';
import 'package:e_mart/src/features/products/presentation/component/top_bar.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_controller.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  StreamSubscription? _internetConnectivityStream;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _internetConnectivityStream = HelperFunctions.internetConnectivityChecker();
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
      appBar: AppBar(
        title: TopBar(),
        leadingWidth: 0,
        leading: SizedBox.shrink(),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              productController.doesLoading!
                  ? ProductGridShimmer()
                  : Column(
                    children: [
                      if (productController.doesSearching!)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              "${productController.products!.length} Items",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      if (productController.products!.isNotEmpty)
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
                            return InkWell(
                              onTap: () => context.pushNamed(RoutesName.product, extra: product),
                              child: ProductCard(product: product),
                            );
                          },
                        ),
                      if (productController.doesSearching == false &&
                          productController.products!.isNotEmpty)
                        DetectVisibility(),
                      if (productController.products!.isEmpty)
                        Image.asset(AppImagesPath.noProductFound),
                    ],
                  ),
        ),
      ),
    );
  }
}
