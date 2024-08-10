import 'package:flutter/material.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/invest_card.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class CompletedInvestments extends StatefulWidget {
  const CompletedInvestments({Key? key}) : super(key: key);

  @override
  _CompletedInvestmentsState createState() => _CompletedInvestmentsState();
}

class _CompletedInvestmentsState extends State<CompletedInvestments> {
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
      'status': '2',
    };

    _future = _allRepos.getInvestHistory(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      title: 'Investments History',
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
                  return InvestmentCard(
                    data: _datas[index],
                  );
                },
              );
            }
          }),
    );
  }
}
