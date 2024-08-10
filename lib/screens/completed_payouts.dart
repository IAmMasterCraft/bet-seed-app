import 'package:flutter/material.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/payout_card.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class CompletedPayouts extends StatefulWidget {
  const CompletedPayouts({Key? key}) : super(key: key);

  @override
  _CompletedPayoutsState createState() => _CompletedPayoutsState();
}

class _CompletedPayoutsState extends State<CompletedPayouts> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;

  @override
  void initState() {
    _getPayouts();
    _loadMore(true);

    super.initState();
  }

  bool _loading = false;
  List<int> lData = [];
  int currentLength = 0;

  final int increment = 10;

  Future _loadMore(bool isInit) async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(Duration(seconds: isInit ? 0 : 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      lData.add(i);
    }
    setState(() {
      _loading = false;
      currentLength = lData.length;
    });
  }

  _getPayouts() {
    Map data = {
      'status': '2',
    };

    _future = _allRepos.getPayouts(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Completed Payouts',
      body: FutureBuilder<List>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ProgIndicator();
            } else {
              List? _datas = snapshot.data;

              return LazyLoadWid(
                isLoading: _loading,
                data: _datas!,
                lData: lData,
                onEndOfPage: () => _loadMore(false),
                itemBuilder: (context, int index) {
                  return PayoutsCard(
                    data: _datas[index],
                  );
                },
              );
            }
          }),
    );
  }
}
