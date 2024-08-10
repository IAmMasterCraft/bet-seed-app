import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/screens/create_package.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/package_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class PackageInvestments extends StatefulWidget {
  const PackageInvestments({Key? key}) : super(key: key);

  @override
  _PackageInvestmentsState createState() => _PackageInvestmentsState();
}

class _PackageInvestmentsState extends State<PackageInvestments> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;
  @override
  void initState() {
    super.initState();
    _getInvestPackages();
  }

  Future<List>? _getInvestPackages() {
    Map data = {
      'type': "2",
    };
    _future = _allRepos.getPackages(data);
    return _future;
  }

  _refresh() async {
    await _getInvestPackages();
    setState(() {});
    Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      onRefresh: () async => _refresh()!,
      title: 'Packages',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createPackage,
        label: Text('Create'),
        icon: Icon(
          IconlyLight.plus,
        ),
      ),
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
                        _getInvestPackages();
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
        builder: (_) => CreatePackage(type: 2),
      ),
    );
    setState(() {
      _getInvestPackages();
    });
  }
}
