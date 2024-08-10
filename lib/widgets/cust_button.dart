import 'package:flutter/material.dart';
import 'package:bet_seed/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: accent,
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            color: primaryColor,
          ),
        )),
      ),
    );
  }
}
