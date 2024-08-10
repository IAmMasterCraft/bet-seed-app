import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/models/tips_model.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/utils/strings.dart';

import 'tips_card_row.dart';

class TipsCard extends StatefulWidget {
  const TipsCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _TipsCardState createState() => _TipsCardState();
}

class _TipsCardState extends State<TipsCard> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    var _tips = TipsModel.fromJson(widget.data);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TipsCardRow(
                  title: _tips.sportType,
                  value: _tips.league,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TipsCardRow(
                      title: _tips.teamOne + ' - ' + _tips.teamTwo,
                      value: _tips.sportTime,
                    ),
                    TipsCardRow(
                      title: _tips.tips,
                      value: _tips.odds,
                    ),
                    TipsCardRow(
                      title: 'Probability',
                      value: _tips.probability + ' %',
                      // color: statusColor[_tips.status],
                    ),
                    TipsCardRow(
                      title: 'Status',
                      value: TIPSSTATUS[_tips.status],
                      color: statusColor[_tips.status],
                    ),
                    Divider(
                      color: primaryColor,
                    ),
                    TipsCardRow(
                      title: 'Update Status',
                      widget: Row(
                        children: [
                          IconButton(
                            onPressed: () => _accepRejectDeletePop(
                              value: 'mark this tip as Won',
                              isDelete: false,
                              tips: _tips,
                              isWin: true,
                            ),
                            icon: Icon(
                              IconlyLight.tickSquare,
                              color: primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _accepRejectDeletePop(
                              value: 'mark this tip as Lost',
                              isDelete: false,
                              tips: _tips,
                              isWin: false,
                            ),
                            icon: Icon(
                              IconlyLight.closeSquare,
                              color: redAccent,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _accepRejectDeletePop(
                              value: 'delete this tip',
                              isDelete: true,
                              tips: _tips,
                              isWin: true,
                            ),
                            icon: Icon(
                              IconlyLight.delete,
                              color: red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _accepRejectDeletePop(
      {String? value, bool? isDelete, bool? isWin, TipsModel? tips}) {
    _allRepos.showPopUp(context, Text("Are you sure you want to $value?"), [
      CupertinoButton(
          child: Text("Yes"), onPressed: () => _fxn(isDelete!, tips!, isWin!)),
      CupertinoButton(
        child: Text("No"),
        onPressed: () => Navigator.pop(context),
      ),
    ], [
      TextButton(
          child: Text("Yes"), onPressed: () => _fxn(isDelete!, tips!, isWin!)),
      TextButton(
        child: Text("No"),
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }

  _fxn(bool isDelete, TipsModel _tips, bool isWin) {
    isDelete ? _deleteFxn(_tips) : _winLoseFxn(_tips, isWin);
    Navigator.pop(context);
  }

  _winLoseFxn(TipsModel _tips, bool isWin) async {
    String freePaid = _tips.freePaid == 0 ? 'freeTips' : 'paidTips';
    Map data = {
      'freePaid': freePaid,
      'sportId': _tips.sportId,
      'status': isWin ? '2' : '0',
    };
    try {
      await _allRepos.wlTips(data, context);
      await _tips.refreshFxn!();
    } catch (e) {
      print(e);
    }
  }

  _deleteFxn(TipsModel _tips) async {
    String freePaid = _tips.freePaid == 0 ? 'freeTips' : 'paidTips';

    Map data = {
      'freePaid': freePaid,
      'sportId': _tips.sportId,
    };
    try {
      await _allRepos.deleteTips(data, context);
      await _tips.refreshFxn!();
    } catch (e) {
      print(e);
    }
  }
}
