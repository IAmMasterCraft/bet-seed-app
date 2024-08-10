import 'package:flutter/material.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/tile_widget.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Subscriptions',
      body: Column(
        children: [
          TileWid(
            title: 'Packages',
            routeName: '/package-subscriptions',
          ),
          Divider(
            indent: 8.0,
            color: primaryColor,
          ),
          TileWid(
            title: 'History',
            routeName: '/completed-subscriptions',
          ),
        ],
      ),
    );
  }
}
