import 'package:flutter/material.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/tile_widget.dart';

class Payouts extends StatefulWidget {
  const Payouts({Key? key}) : super(key: key);

  @override
  _PayoutsState createState() => _PayoutsState();
}

class _PayoutsState extends State<Payouts> {
  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Payouts',
      body: Column(
        children: [
          TileWid(
            title: 'Pending',
            routeName: '/pending-payouts',
          ),
          TileWid(
            title: 'Completed',
            routeName: '/completed-payouts',
          ),
          TileWid(
            title: 'Failed',
            routeName: '/failed-payouts',
          ),
        ],
      ),
    );
  }
}
