import 'package:flutter/material.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/tile_widget.dart';

class Coins extends StatefulWidget {
  const Coins({Key? key}) : super(key: key);

  @override
  _CoinsState createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Coins',
      body: Column(
        children: [
          TileWid(
            title: 'Packages',
            routeName: '/coin-packages',
          ),
          Divider(
            indent: 8.0,
            color: primaryColor,
          ),
          TileWid(
            title: 'Purchases',
            routeName: '/coin-purchase',
          ),
        ],
      ),
    );
  }
}
