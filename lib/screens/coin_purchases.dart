import 'package:flutter/material.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/coin_card.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class CoinPurchases extends StatefulWidget {
  const CoinPurchases({Key? key}) : super(key: key);

  @override
  _CoinPurchasesState createState() => _CoinPurchasesState();
}

class _CoinPurchasesState extends State<CoinPurchases> {
  AllRepos _allRepos = AllRepos();
  Future<List>? _future;

  @override
  void initState() {
    _getHistory();
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

  _getHistory() {
    Map data = {
      'type': '0',
    };

    _future = _allRepos.getHistory(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Coin Purchases',
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
                  return CoinHistoryCard(
                    data: _datas[index],
                  );
                },
              );
            }
          }),
    );
  }
}
