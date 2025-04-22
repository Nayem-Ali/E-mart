import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_mart/src/core/router/routes_name.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/presentation/component/info_chip.dart';
import 'package:e_mart/src/features/products/presentation/component/price_tag.dart';
import 'package:e_mart/src/features/products/presentation/component/product_card.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_controller.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_generic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await ref
          .read(productProvider.notifier)
          .fetchCategorizedProducts(categoryName: widget.product.category);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductGeneric productController = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Product Details"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                // height: context.size!.height * 0.4,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
              ),
              items:
                  widget.product.images.map((imageUrl) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        // width: context.size?.width,
                        placeholder:
                            (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                color: Colors.white,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),

                        errorWidget:
                            (context, url, error) => Center(child: Icon(Icons.image, size: 200)),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(widget.product.title, style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: PriceTag(product: widget.product),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(widget.product.description),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    "Overall Rating: (${widget.product.rating}/5) ",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  StarRating(
                    rating: widget.product.rating,
                    mainAxisAlignment: MainAxisAlignment.start,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  InfoChip(label: "Stock", value: widget.product.stock.toString()),
                  InfoChip(label: "Return", value: widget.product.returnPolicy),
                  InfoChip(label: "Brand", value: widget.product.brand),
                  InfoChip(label: "Warranty", value: widget.product.warrantyInformation),
                  InfoChip(label: "Category", value: widget.product.category.toUpperCase()),
                ],
              ),
            ),

            ExpansionTile(
              title: Text("Reviews (${widget.product.reviews.length})"),
              children:
                  widget.product.reviews
                      .map(
                        (review) => ListTile(
                          title: Text(
                            "${review.reviewerName} (${review.rating})",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(review.comment),
                          trailing: SizedBox(
                            width: 80,
                            child: StarRating(
                              rating: review.rating.toDouble(),
                              size: 15,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            if (productController.categorizedProducts!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Similar Products (${productController.categorizedProducts!.length - 1})",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            if (productController.categorizedProducts!.isNotEmpty)
              // Text("Similar Products ${[productController.categorizedProducts?.length]}"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.categorizedProducts?.length ?? 0,
                  itemBuilder: (context, index) {
                    Product product = productController.categorizedProducts![index];
                    if (product.id == widget.product.id) return SizedBox.shrink();
                    return InkWell(
                      onTap: () => context.pushNamed(RoutesName.product, extra: product),
                      child: SizedBox(width: 200, child: ProductCard(product: product)),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
