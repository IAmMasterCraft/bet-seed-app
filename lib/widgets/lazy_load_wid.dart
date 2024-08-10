import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'prog_indicator.dart';

class LazyLoadWid extends StatelessWidget {
  const LazyLoadWid({
    Key? key,
    required this.isLoading,
    required this.data,
    required this.lData,
    required this.onEndOfPage,
    required this.itemBuilder,
  }) : super(key: key);

  final bool isLoading;
  final List<dynamic> data;
  final List<int> lData;

  final Function() onEndOfPage;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    Size med = MediaQuery.of(context).size;

    return Column(
      children: [
        LazyLoadScrollView(
          isLoading: isLoading,
          onEndOfPage: onEndOfPage,
          child: Container(
            height: med.height * 0.8,
            child: ListView.builder(
              itemCount:
                  lData.length > data.length ? data.length : lData.length,
              itemBuilder: itemBuilder,
            ),
          ),
        ),
        isLoading ? ProgIndicator() : SizedBox.shrink(),
      ],
    );
  }
}
