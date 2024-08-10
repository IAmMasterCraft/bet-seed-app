import 'package:flutter/material.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/tile_widget.dart';

class Tips extends StatefulWidget {
  const Tips({Key? key}) : super(key: key);

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Tips',
      body: Column(
        children: [
          TileWid(
            title: 'New Free',
            routeName: '/free-tips',
          ),
          TileWid(
            title: 'New Premium',
            routeName: '/premium-tips',
          ),
          Divider(
            indent: 8.0,
            color: primaryColor,
          ),
          TileWid(
            title: 'Past',
            routeName: '/past-tips',
          ),
        ],
      ),
    );
  }
}
