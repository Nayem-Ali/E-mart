import 'package:e_mart/src/core/utils/helper_functions/helper_functions.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:flutter/material.dart';
class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return product.discountPercentage != 0 ? RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: "\$${HelperFunctions.calculateDiscount(product: product)} ",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.shadow,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\$${product.price}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationColor: Theme.of(context).colorScheme.shadow.withAlpha(95),
              decorationThickness: 2,
              color: Theme.of(context).colorScheme.shadow.withAlpha(95)
            ),
          ),
          TextSpan(
            text: " ${product.discountPercentage}% OFF",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ) : Text(
      "\$${product.price.toStringAsFixed(2)}",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
