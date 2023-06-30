import 'package:flutter/material.dart';

import 'model.dart';
import 'product_card.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final bool showCategories;

  const ProductListWidget({
    super.key,
    required this.products,
    required this.showCategories,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemExtent: showCategories ? null : ProductCard.height,
      itemCount: products.length,
      itemBuilder: (context, i) {
        final product = products[i];
        final card = ProductCard(product: product);

        if (!showCategories) return card;

        if (i > 0) {
          final previousProduct = products[i - 1];
          if (product.category == previousProduct.category) return card;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF1F1F1)),
                ),
              ),
              child: Text(
                product.category.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            card,
          ],
        );
      },
    );
  }
}
