import 'package:flutter/material.dart';
import 'model.dart';

extension _Amount on Amount {
  String get text {
    if (this is Grams) {
      return "${value / 1000} кг";
    } else if (this is Quantity) {
      return "$value шт";
    } else {
      return "$value";
    }
  }
}

class ProductCard extends StatelessWidget {
  static const height = 100.0;
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 68,
            height: 68,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                maxLines: 2,
              ),
              Row(
                children: [
                  Text(product.amount.text),
                  const Spacer(),
                  if (product.hasDiscount) ...[
                    Text(
                      product.originalCost.toString(),
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFB4B4B4),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Text(
                    product.actualCost.toString(),
                    softWrap: false,
                    style: TextStyle(
                      color: product.hasDiscount ? Colors.red : null,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
