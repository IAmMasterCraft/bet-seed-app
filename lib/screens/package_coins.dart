import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/package_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

import 'create_package.dart';

class PackageCoins extends StatefulWidget {
  const PackageCoins({Key? key}) : super(key: key);

  @override
  _PackageCoinsState createState() => _PackageCoinsState();
}

class _PackageCoinsState extends State<PackageCoins> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;
  @override
  void initState() {
    super.initState();
    _getCoinPackages();
  }

  Future<List>? _getCoinPackages() {
    Map data = {
      'type': "0",
    };
    _future = _allRepos.getPackages(data);
    return _future;
  }

  _refresh() async {
    await _getCoinPackages();
    setState(() {});
    Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      onRefresh: () async => _refresh()!,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createPackage,
        label: Text('Create'),
        icon: Icon(
          IconlyLight.plus,
        ),
      ),
      title: 'Packages',
      body: FutureBuilder<List>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ProgIndicator();
            } else {
              var data = snapshot.data;

              return ListView.builder(
                  itemCount: data!.length,
                  padding: const EdgeInsets.only(bottom: 100),
                  itemBuilder: (_, int index) {
                    data[index]['refreshFxn'] = () {
                      setState(() {
                        _getCoinPackages();
                      });
                    };
                    return PackageWid(data: data[index]);
                  });
            }
          }),
    );
  }

  _createPackage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreatePackage(type: 0),
      ),
    );
    setState(() {
      _getCoinPackages();
    });
  }
}
