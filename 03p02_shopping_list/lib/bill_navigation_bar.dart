import 'package:flutter/material.dart';

class BillNavigationBar extends BottomNavigationBar {
  static const _items = [
    ("Каталог", Icons.article_outlined),
    ("Поиск", Icons.search),
    ("Корзина", Icons.local_mall_outlined),
    ("Личное", Icons.person_outline),
  ];

  BillNavigationBar({super.key})
      : super(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          items: [
            for (final (label, icon) in _items)
              BottomNavigationBarItem(
                icon: Icon(icon),
                label: label,
              ),
          ],
        );
}
