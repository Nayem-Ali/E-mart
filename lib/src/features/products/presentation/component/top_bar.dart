import 'package:e_mart/src/core/constants/app_icons_path.dart';
import 'package:e_mart/src/core/utils/helper_functions/helper_functions.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopBar extends ConsumerStatefulWidget {
  const TopBar({super.key});

  @override
  ConsumerState<TopBar> createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<TopBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _searchController,
            onFieldSubmitted: (value) {
              ref.read(productProvider.notifier).searchProduct(query: value.trim());
            },
            onChanged: (value) {
              if(value.isEmpty){
                ref.read(productProvider.notifier).fetchAllProducts();
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Image.asset(AppIconsPath.searchIcon),
              hintText: "Search Anything...",
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                List<String> sortOptions = HelperFunctions.sortingOptions();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        "Sort By",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    ),

                    ...sortOptions.map(
                      (option) => ListTile(
                        title: Text(option),
                        onTap: () {
                          ref.read(productProvider.notifier).sortProducts(option: option);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Image.asset(AppIconsPath.sortIcon),
        ),
      ],
    );
  }
}
