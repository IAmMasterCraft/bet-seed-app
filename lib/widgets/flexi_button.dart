import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/utils/colors.dart';

class FlexButton extends StatelessWidget {
  const FlexButton({
    Key? key,
    required this.isApprove,
    this.fxn,
  }) : super(key: key);

  final bool isApprove;
  final Function()? fxn;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: fxn,
        child: Container(
          height: 30,
          color: isApprove ? accent : redAccent,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isApprove ? IconlyLight.tickSquare : IconlyLight.closeSquare,
                size: 20,
              ),
              Text(
                isApprove ? " Approve" : " Reject",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
