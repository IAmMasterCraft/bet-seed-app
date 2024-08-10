import 'package:flutter/material.dart';

class TipsCardRow extends StatelessWidget {
  const TipsCardRow({
    Key? key,
    required this.title,
    this.value,
    this.color,
    this.widget,
  }) : super(key: key);

  final String title;
  final String? value;
  final Color? color;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          widget ??
              Text(
                value!,
                style: TextStyle(
                  color: color,
                ),
              ),
        ],
      ),
    );
  }
}
