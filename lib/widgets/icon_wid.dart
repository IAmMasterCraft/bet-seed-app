import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/utils/colors.dart';

class IconWid extends StatelessWidget {
  const IconWid({
    Key? key,
    this.fxn,
    required this.isApprove,
  }) : super(key: key);

  final int isApprove;
  final Function()? fxn;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: fxn,
      icon: Icon(
        isApprove == 0
            ? IconlyLight.tickSquare
            : isApprove == 1
                ? IconlyLight.closeSquare
                : IconlyLight.arrowDownSquare,
        size: 30,
        color: isApprove == 0
            ? primaryColor
            : isApprove == 1
                ? red
                : null,
      ),
    );
  }
}
