import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class TileWid extends StatelessWidget {
  const TileWid({
    Key? key,
    required this.title,
    required this.routeName,
  }) : super(key: key);

  final String title;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, routeName),
      title: Text(title),
      trailing: Icon(
        IconlyLight.arrowRight2,
      ),
    );
  }
}
