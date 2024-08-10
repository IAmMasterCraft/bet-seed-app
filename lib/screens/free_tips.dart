import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/screens/add_tips.dart';

import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';
import 'package:bet_seed/widgets/tips_card.dart';

class FreeTips extends StatefulWidget {
  const FreeTips({Key? key}) : super(key: key);

  @override
  _FreeTipsState createState() => _FreeTipsState();
}

class _FreeTipsState extends State<FreeTips> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;
  @override
  void initState() {
    super.initState();
    _getTips();
  }

  Future<List>? _getTips() {
    String _date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    String _freePaid = 'freeTips';
    Map data = {
      'freePaid': _freePaid,
      'sportDate': _date,
    };
    _future = _allRepos.getTips(data, context);
    return _future;
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Free Tips',
      centerTitle: false,
      hasDate: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTips(isFree: true),
            ),
          );
          setState(() {
            _getTips();
          });
        },
        label: Text('Add Tips'),
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
              List? data = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data!.length,
                  itemBuilder: (context, int index) {
                    data[index]['freePaid'] = 0;
                    data[index]['refreshFxn'] = () {
                      setState(() {
                        _getTips();
                      });
                    };
                    return TipsCard(data: data[index]);
                  });
            }
          }),
    );
  }
}
