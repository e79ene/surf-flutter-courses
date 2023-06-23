/// Модель продукта.
///
/// Содержит в себе название, цену, категорию и ссылку на изображение.
class ProductEntity {
  /// Название товара.
  final String title;

  /// Цена товара в копейках. Без скидки.
  ///
  /// Подумайте и ответьте на три вопроса:
  /// 1. Почему цена хранится в копейках, а не в рублях?
  /// 2. Почему тип данных цены - [int], а не [double]?
  /// 3. Как можно было реализовать передачу цены иначе?
  ///
  /// Ответы на вопросы разместите тут (они будут проверены при код-ревью):
  ///
  /// [ОТВЕТЫ]
  /// 1. Потому что в комейках любую сумму можно представить целым числом.
  /// 2. Потому что такой код:
  ///     double zero = 1000.01 - 1000 - 0.01;
  ///     print(zero);
  ///     print(zero < 0);
  ///   выведет:
  ///     -9.0951551845464e-15
  ///     true
  ///   что является неожиданным результатом при работе с деньгами.
  ///   Например человек погасил долг, но система будет считать что он ещё что-то
  ///   должен, т.к. балланс не равен 0.
  ///   Этот эффект происходит из того что double представляет чилса в двоичной системе
  ///   , а многие десятичные дроби не могут быть представленны конечной двоичной дробью,
  ///   и поэтому в double могут быть представлены с некоторой погрешностью.
  ///  3. Использовать десятичное представление чисел. Напр: https://pub.dev/packages/decimal
  final int price;

  /// Категория товара.
  final Category category;

  /// Ссылка на изображение товара.
  final String imageUrl;

  /// Количество товара.
  ///
  /// Может быть описано в граммах [Grams] или в штуках [Quantity].
  final Amount amount;

  /// Скидка на товар.
  ///
  /// Требуется высчитать самостоятельно итоговую цену товара.
  final double sale;

  ProductEntity({
    required this.title,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.amount,
    this.sale = 0,
  });

  bool get hasDiscount => sale != 0;

  double get _calculatingAmount => amount.value / (amount is Grams ? 1000 : 1);

  double get _actualPrice => price * (hasDiscount ? (100 - sale) / 100 : 1);

  Sum get actualCost => Sum(_actualPrice * _calculatingAmount);

  Sum get originalCost => Sum(price * _calculatingAmount);
}

class Sum implements Comparable<Sum> {
  final double pennies;

  const Sum(this.pennies);

  @override
  String toString() => "${(pennies / 100).toStringAsFixed(2)} руб";

  @override
  int compareTo(other) {
    return pennies.compareTo(other.pennies);
  }
}

/// Класс, описывающий количество товара.
sealed class Amount {
  int get value;
}

/// Класс, описывающий количество товара в граммах.
class Grams implements Amount {
  @override
  final int value;
  Grams(this.value);
}

/// Класс, описывающий количество товара в штуках.
class Quantity implements Amount {
  @override
  final int value;
  Quantity(this.value);
}

/// Категория товара.
enum Category {
  food('Продукты питания'),
  tech('Технологичные товары'),
  care('Уход'),
  drinks('Напитки'),
  drugs('Медикаменты');

  final String name;

  const Category(this.name);
}

class Sorting {
  final String? parameter;
  final String name;
  final Comparator<ProductEntity>? comparator;
  final bool showCategories;

  bool get unsorted => comparator == null;

  const Sorting( {
    required this.parameter,
    required this.name,
    required this.comparator,
    this.showCategories = false,
  });
}
