import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';
import 'package:bet_seed/widgets/tips_card.dart';

import 'add_tips.dart';

class PremiumTips extends StatefulWidget {
  const PremiumTips({Key? key}) : super(key: key);

  @override
  _PremiumTipsState createState() => _PremiumTipsState();
}

class _PremiumTipsState extends State<PremiumTips> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;

  @override
  void initState() {
    super.initState();
    _getTips();
  }

  _getTips() {
    String _date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    String _freePaid = 'paidTips';
    Map data = {
      'freePaid': _freePaid,
      'sportDate': _date,
    };
    _future = _allRepos.getTips(data, context);
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Premium Tips',
      centerTitle: false,
      hasDate: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTips(isFree: false),
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
                    data[index]['freePaid'] = 1;
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
