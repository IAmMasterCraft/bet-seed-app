import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/tile_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Home',
      actionIcon: IconButton(
        icon: Icon(IconlyLight.logout),
        onPressed: () {
          _allRepos.logOut(context).then((value) {
            if (value) {
              Navigator.pushReplacementNamed(context, '/sign-in');
            }
          });
        },
      ),
      onTap: () {},
      body: Column(
        children: [
          TileWid(
            title: 'Users',
            routeName: '/users',
          ),
          TileWid(
            title: 'Tips',
            routeName: '/tips',
          ),
          TileWid(
            title: 'Coins',
            routeName: '/coins',
          ),
          TileWid(
            title: 'Subscriptions',
            routeName: '/subscriptions',
          ),
          TileWid(
            title: 'Investments',
            routeName: '/investments',
          ),
          TileWid(
            title: 'Payouts',
            routeName: '/payouts',
          ),
          TileWid(
            title: 'Disbursed Interests',
            routeName: '/interests',
          ),
          TileWid(
            title: 'Adverts',
            routeName: '/adverts',
          ),
          TileWid(
            title: 'Notifications',
            routeName: '/notifications',
          ),
        ],
      ),
    );
  }
}
