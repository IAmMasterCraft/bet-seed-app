import 'package:flutter/material.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/invest_card.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class PendingInvestments extends StatefulWidget {
  const PendingInvestments({Key? key}) : super(key: key);

  @override
  _PendingInvestmentsState createState() => _PendingInvestmentsState();
}

class _PendingInvestmentsState extends State<PendingInvestments> {
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
      'status': '1',
    };

    _future = _allRepos.getInvestHistory(data);
  }

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      isLoading: _loading,
      title: 'Pending Investments',
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
                  _datas[index]['type'] = 1;
                  return InvestmentCard(
                    data: _datas[index],
                    approve: () => _acceptRejectFxn(_datas[index], 2),
                    reject: () => _acceptRejectFxn(_datas[index], 0)(),
                  );
                },
              );
            }
          }),
    );
  }

  _acceptRejectFxn(Map data, int type) async {
    setState(() {
      _loading = true;
    });
    try {
      Map _data = {
        'status': type.toString(),
        "reference": data['reference'],
        "email": data['email'],
        "title": data['title'],
        "amount": data['amount'],
        "duration": data['duration'].toString(),
        "roi": data['roi'],
      };
      print(_data);
      Navigator.pop(context);

      await _allRepos.approveRejectInvestment(_data, context);
    } catch (e) {
      print('e is $e');
    }
    setState(() {
      _loading = false;
      _getHistory();
    });
  }
}
