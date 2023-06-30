import 'package:flutter/material.dart';

import 'model.dart';

class BillTotalsWidget extends StatelessWidget {
  final Iterable<ProductEntity> products;
  late Sum originalCost;
  late Sum actualCost;
  late double discountPercent;
  late Sum discountSum;

  BillTotalsWidget({
    super.key,
    required this.products,
  }) {
    double original = 0;
    double actual = 0;
    for (final product in products) {
      original += product.originalCost.pennies;
      actual += product.actualCost.pennies;
    }
    originalCost = Sum(original);
    actualCost = Sum(actual);
    final discount = original - actual;
    discountSum = Sum(discount);
    discountPercent = discount / original * 100;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Color(0xFFF1F1F1)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "В вашей покупке",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${products.length} товаров",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                "$originalCost",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Скидка ${discountPercent.toStringAsFixed(2)}%",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                "-$discountSum",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Итого",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$actualCost",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
