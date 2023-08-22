import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final String text;

  const EmptyContent({
    super.key,
    required this.onRefresh,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: [
          ListView(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search_off_rounded,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => onRefresh.call(),
                  child: const Text('Volver a cargar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
