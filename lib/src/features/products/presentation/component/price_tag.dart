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
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: "\$${HelperFunctions.calculateDiscount(product: product)} ",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\$${product.price}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationThickness: 2,
            ),
          ),
          TextSpan(
            text: " ${product.discountPercentage}% off",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(),
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
