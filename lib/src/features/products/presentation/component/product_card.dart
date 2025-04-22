import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_mart/src/core/constants/app_icons_path.dart';
import 'package:e_mart/src/core/database/hive/dao/favourite_product_dao.dart';
import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:flutter/material.dart';

import 'price_tag.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final FavouriteProductDao _favouriteDao = sl.get<FavouriteProductDao>();
  final ValueNotifier<bool> _doesFavourite = ValueNotifier<bool>(false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _doesFavourite.value = _favouriteDao.checkFavourite(product: widget.product);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (_doesFavourite.value)  {
                          await _favouriteDao.removeFromFavourite(product: widget.product);
                        } else {
                          await _favouriteDao.addToFavourite(product: widget.product);
                        }
                        _doesFavourite.value = _favouriteDao.checkFavourite(
                          product: widget.product,
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: _doesFavourite,
                        builder: (context, value, child) {
                          return Icon(
                            Icons.favorite,
                            size: 20,
                            color: value ? Colors.redAccent : Colors.black,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (widget.product.stock == 0)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        "Out of Stock",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.title,
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          PriceTag(product: widget.product),
          const SizedBox(height: 4),
          Row(
            children: [
              Image.asset(AppIconsPath.ratingIcon),
              Text(" ${widget.product.rating}(${widget.product.reviews.length})"),
            ],
          ),
        ],
      ),
    );
  }
}
