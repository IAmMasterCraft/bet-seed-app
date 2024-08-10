import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/widgets/ads_tile.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class Adverts extends StatefulWidget {
  const Adverts({Key? key}) : super(key: key);

  @override
  _AdvertsState createState() => _AdvertsState();
}

class _AdvertsState extends State<Adverts> {
  AllRepos _allRepos = AllRepos();

  Future<List>? _getAds(int _adsType) {
    Map data = {
      'adsType': _adsType.toString(),
    };
    return _allRepos.getAds(data, context);
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Adverts',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, '/create-adverts');

          setState(() {
            _getAds(0);
            _getAds(1);
          });
        },
        label: Text('Create'),
        icon: Icon(
          IconlyLight.plus,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Pop Up'),
          ),
          FutureBuilder<List>(
            future: _getAds(0),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: ProgIndicator(),
                );
              } else {
                List? data = snapshot.data;

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (_, int index) {
                      data[index]['refreshFxn'] = () {
                        setState(() {
                          _getAds(0);
                        });
                      };
                      return AdsTile(
                        data: data[index],
                      );
                    });
              }
            },
          ),
          Divider(
            color: primaryColor,
            indent: 8.0,
          ),
          ListTile(
            title: Text('Carousel'),
          ),
          FutureBuilder<List>(
            future: _getAds(1),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: ProgIndicator(),
                );
              } else {
                List? data = snapshot.data;

                return ListView.builder(
                    itemCount: data!.length,
                    shrinkWrap: true,
                    itemBuilder: (_, int index) {
                      data[index]['refreshFxn'] = () {
                        setState(() {
                          _getAds(1);
                        });
                      };
                      return AdsTile(
                        data: data[index],
                      );
                    });
              }
            },
          )
        ],
      ),
    );
  }
}
