import 'package:flutter/material.dart';

import 'bill_app_bar.dart';
import 'bill_navigation_bar.dart';
import 'bill_totals_widget.dart';
import 'model.dart';
import 'product_list_widget.dart';
import 'sorting_widget.dart';

class BillScreen extends StatefulWidget {
  final int billNo;
  final DateTime dateTime;
  final Iterable<ProductEntity> products;
  final List<Sorting> sortings;

  const BillScreen({
    super.key,
    required this.billNo,
    required this.dateTime,
    required this.products,
    required this.sortings,
  });

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  late Sorting currentSorting;
  late List<ProductEntity>? sortedProducts;

  @override
  void initState() {
    currentSorting = widget.sortings.firstWhere((s) => s.unsorted);
    sortedProducts = widget.products.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: BillAppBar(billNo: widget.billNo, dateTime: widget.dateTime),
      body: widget.products.isEmpty
          ? const Center(child: Text("Здесь пока ничего нет"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 20),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Список покупок",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Stack(
                            children: [
                              const Icon(Icons.sort),
                              if (!currentSorting.unsorted)
                                Positioned(
                                  right: 0,
                                  bottom: 2,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: ShapeDecoration(
                                      color: colors.primary,
                                      shape: const OvalBorder(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          onPressed: () async {
                            final newSorting =
                                await showModalBottomSheet<Sorting>(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              builder: (context) => SortingWidget(
                                sortings: widget.sortings,
                                currentSorting: currentSorting,
                              ),
                            );
                            await _sortProducts(newSorting);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: buildProductList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 32),
                    child: BillTotalsWidget(products: widget.products),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BillNavigationBar(),
    );
  }

  Widget buildProductList() {
    final products = sortedProducts;
    return products != null
        ? ProductListWidget(
            products: products,
            showCategories: currentSorting.showCategories,
          )
        : const Center(
            child: SizedBox.square(
              dimension: 200,
              child: CircularProgressIndicator(),
            ),
          );
  }

  Future<void> _sortProducts(Sorting? newSorting) async {
    if (newSorting == null || newSorting == currentSorting) return;

    setState(() {
      currentSorting = newSorting;
      sortedProducts = null;
    });

    final products = widget.products.toList();
    if (!currentSorting.unsorted) {
      products.sort(currentSorting.comparator);
    }
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      sortedProducts = products;
    });
  }
}
