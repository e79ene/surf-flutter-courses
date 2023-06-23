import 'model.dart';

final allSortings = [
  const Sorting(
    parameter: null,
    name: "Без сортировки",
    comparator: null,
  ),
  const Sorting(
    parameter: "По имени",
    name: "По имени  от А до Я",
    comparator: _titleComparator,
  ),
  Sorting(
    parameter: "По имени",
    name: "По имени  от Я до А",
    comparator: (a, b) => -_titleComparator(a, b),
  ),
  const Sorting(
    parameter: "По цене",
    name: "По возрастанию",
    comparator: _priceComparator,
  ),
  Sorting(
    parameter: "По цене",
    name: "По убыванию",
    comparator: (a, b) => -_priceComparator(a, b),
  ),
  const Sorting(
    parameter: "По типу",
    name: "По типу от А до Я",
    comparator: _categoryComparator,
    showCategories: true,
  ),
  Sorting(
    parameter: "По типу",
    name: "По типу от Я до А",
    comparator: (a, b) => -_categoryComparator(a, b),
    showCategories: true,
  ),
];

int _titleComparator(ProductEntity a, ProductEntity b) =>
    a.title.compareTo(b.title);

int _priceComparator(ProductEntity a, ProductEntity b) =>
    a.actualCost.compareTo(b.actualCost);

int _categoryComparator(ProductEntity a, ProductEntity b) =>
    a.category.name.compareTo(b.category.name);
