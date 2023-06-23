import 'package:flutter/material.dart';

import 'model.dart';

class SortingWidget extends StatefulWidget {
  final List<Sorting> sortings;
  final Sorting currentSorting;

  const SortingWidget(
      {super.key, required this.sortings, required this.currentSorting});

  @override
  State<SortingWidget> createState() => _SortingWidgetState();
}

class _SortingWidgetState extends State<SortingWidget> {
  late Sorting currentSorting;

  @override
  void initState() {
    currentSorting = widget.currentSorting;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 32),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Сортировка",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                CloseButton(),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.sortings.length,
            itemBuilder: (context, i) {
              final sorting = widget.sortings[i];

              return RadioListTile(
                value: sorting,
                groupValue: currentSorting,
                onChanged: (value) => setState(() => currentSorting = value!),
                title: Text(
                  sorting.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                contentPadding: const EdgeInsets.all(0),
              );
            },
            separatorBuilder: (context, i) {
              final prev = widget.sortings[i];
              final next = widget.sortings[i + 1];
              if (next.parameter == prev.parameter) {
                return const SizedBox.shrink();
              }

              return Container(
                padding: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFF1F1F1)),
                  ),
                ),
                child: Text(
                  "${next.parameter}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: ElevatedButton(
              child: const Text("Готово"),
              onPressed: () => Navigator.pop(context, currentSorting),
            ),
          ),
        ],
      ),
    );
  }
}
