import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/widgets/custom_scaffold.dart';
import 'package:bet_seed/widgets/lazy_load_wid.dart';
import 'package:bet_seed/widgets/payout_card.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class PendingPayouts extends StatefulWidget {
  const PendingPayouts({Key? key}) : super(key: key);

  @override
  _PendingPayoutsState createState() => _PendingPayoutsState();
}

class _PendingPayoutsState extends State<PendingPayouts> {
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
      'status': '1',
    };

    _future = _allRepos.getPayouts(data);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustonScaffold(
      isLoading: isLoading,
      title: 'Pending Payouts',
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
                    reject: () => _acceptReject(_datas[index], 0),
                    approve: () => _acceptReject(_datas[index], 2),
                  );
                },
              );
            }
          }),
    );
  }

  _acceptReject(Map data, int type) async {
    try {
      setState(() {
        isLoading = true;
      });
      Map _data = {
        'reference': data['reference'],
        'status': type.toString(),
      };
      Navigator.pop(context);
      Navigator.pop(context);

      await _allRepos.approveRejectPayout(_data, context);
    } catch (e) {
      print(e);
    }
    setState(() {
      _getPayouts();

      isLoading = false;
    });
  }
}
