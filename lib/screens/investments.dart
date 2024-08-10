import 'package:flutter/material.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/tile_widget.dart';

class Investments extends StatefulWidget {
  const Investments({Key? key}) : super(key: key);

  @override
  _InvestmentsState createState() => _InvestmentsState();
}

class _InvestmentsState extends State<Investments> {
  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Investments',
      body: Column(
        children: [
          TileWid(
            title: 'Packages',
            routeName: '/package-investments',
          ),
          Divider(
            indent: 8.0,
            color: primaryColor,
          ),
          TileWid(
            title: 'Running',
            routeName: '/running-investments',
          ),
          TileWid(
            title: 'Pending',
            routeName: '/pending-investments',
          ),
          TileWid(
            title: 'Completed',
            routeName: '/completed-investments',
          ),
          TileWid(
            title: 'Failed',
            routeName: '/failed-investments',
          ),
        ],
      ),
    );
  }
}
